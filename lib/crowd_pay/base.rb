module CrowdPay
  module Base
    module InstanceMethods
      def initialize(opts={})
        opts.each do |k, v|
          associations = self.class.class_variable_get(:@@associations)
          assoc_name = k.downcase.to_sym

          if associations.has_key?(assoc_name)
            klass = associations[assoc_name][:class_name].constantize

            association = v.each_with_object([]) do |data, array|
              obj = klass.new
              obj.assign_attributes(data)
              array << obj
            end

            instance_variable_set("@#{k.downcase}", association)
          else
            instance_variable_set("@#{k}", v)
          end
        end
      end

      def assign_attributes(hash)
        self.send :initialize, hash
      end

      def populate_errors error
        self.errors.add(:api, (error.has_key?("Message") ? error["Message"] : error))
        if error.has_key?("ModelState")
          model_state = error["ModelState"].symbolize_keys!
          model_state.each do |k, v|
            next if k == self.class.name.downcase.to_sym
            v.each do |e|
              self.errors.add(k.to_s.split(".").last, e)
            end
          end
        end
      end

    end

    module ClassMethods
      def create_connection
        @@connection = Faraday.new(:url => domain) do |faraday|
          # faraday.response :logger if Rails.env.develop? || Rails.env.test? # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP

          faraday.headers['X-ApiKey'] = api_key
          faraday.headers['X-PortalKey'] = portal_key

          unless Rails.env.production?
           faraday.headers['X-ByPassValidation'] = "true"
          end
        end
      end

      def parse(response)
        body = JSON.parse response.body

        if body.is_a? Hash
          build_object response.status, body
        else
          body.map do |attributes|
            build_object response.status, attributes
          end
        end
      end

      def build_object status, attributes
        obj = self.new
        case status
        when 200, 201
          attributes = attributes.each_with_object({}) do |(k, v), hash|
            hash[k.downcase] = v
          end

          obj.assign_attributes(attributes)
        when 400, 405, 409, 404
          #FIX ME: 404 catching is not tested
          obj.populate_errors attributes
        else
          obj.errors.add(:base, "Unknown Error Status #{status}: crowd_pay.rb#parse method")
        end
        return obj
      end

      def get(url)
        with_response_logging "GET #{url}" do
          connection.get do |req|
            req.url(url)
            req.headers['Content-Type'] = 'application/json'
          end
        end
      end

      def post(url, data, bypass_validation=false)
        data = data.to_json unless data.kind_of? String

        Rails.logger.debug "POST to CrowdPay #{url} with #{data}"

        with_response_logging "POST #{url}" do
          connection.post do |req|
            req.url(url)
            req.headers['Content-Type'] = 'application/json'
            req.headers['X-CipByPassValidation'] = 'true' if bypass_validation
            req.body = data
          end
        end
      end

      def put(url, data)
        data = data.to_json unless data.kind_of? String

        Rails.logger.debug "PUT to CrowdPay #{url} with #{data}"

        with_response_logging "PUT #{url}" do
          connection.put do |req|
            req.url(url)
            req.headers['Content-Type'] = 'application/json'
            req.body = data
          end
        end
      end

      def delete(url)
        connection.delete do |req|
          req.url(url)
          req.headers['Content-Type'] = 'application/json'
        end
      end

      private

      def with_response_logging request
        response = yield

        Rails.logger.debug "#{request} responded with status: #{response.status} and body: #{response.body}"

        response
      end

      def register_association(assoc_name, details)
        hash = class_variable_get(:@@associations)
        class_variable_set(:@@associations, hash.merge({assoc_name => details.symbolize_keys}.symbolize_keys))
        attr_accessor assoc_name.to_sym
      end
    end

    def self.included(base)
      base.send :include, InstanceMethods
      base.extend ClassMethods
      base.class_eval do
        cattr_reader :domain, :api_key, :portal_key, :connection, :associations

        class_variable_set(:@@domain, ENV["crowd_pay_domain"])
        class_variable_set(:@@api_key, ENV["crowd_pay_api_key"])
        class_variable_set(:@@portal_key, ENV["crowd_pay_portal_key"])
        class_variable_set(:@@associations, {})

        unless(base.class_variable_get(:@@connection))
          connection = base.create_connection
          base.class_variable_set(:@@connection, connection)
        end
      end
    end
  end
end
