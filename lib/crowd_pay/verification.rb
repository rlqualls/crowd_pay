module CrowdPay
  class Verification
    include ActiveModel::AttributeMethods
    include ActiveModel::Validations
    include CrowdPay::Base

    attr_accessor :id, :firstName, :lastName, :address, :city, :state, :zip,
      :taxpayerId, :birthMonth, :birthDay, :birthYear, :created_by_ip_address,
      :message, :key, :questions, :response_body, :request_data, :summary,
      :qualifiers

    def self.verify(data, bypass_validation)
      url = "identification/api/v1/ops/verify-identity"
      response = post(url, data, bypass_validation)
      obj = parse(response)
      obj.response_body = response.body
      obj.request_data = data.to_s
      obj
    end

    def self.verify_answers(data)
      url = "identification/api/v1/ops/verify-answers"
      response = post(url, data)
      obj = parse(response)
      obj.response_body = response.body
      obj.request_data = data.to_s
      obj
    end

    def pass?
      self.message.downcase == 'pass' || self.summary.try(:downcase) == 'pass'
    end

    def fail?
      !pass?
    end

    def soft_fail?
      !self.questions.nil?
    end
  end
end
