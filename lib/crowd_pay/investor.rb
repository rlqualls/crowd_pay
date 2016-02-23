module CrowdPay
  class Investor
    include ActiveModel::AttributeMethods
    include ActiveModel::Validations
    include CrowdPay::Base

    attr_accessor :id, :investor_key, :tax_id_number, :first_name, :middle_name, :last_name, :name, :birth_date, :mailing_address_1, :mailing_address_2, :mailing_city, :mailing_state, :mailing_zip, :mailing_country, :is_mailing_address_foreign, :legal_address_1, :legal_address_2, :legal_city, :legal_state, :legal_zip, :legal_country, :is_legal_address_foreign, :primary_phone, :secondary_phone, :is_person, :email, :is_cip_satisfied, :portal_investor_number, :created_by_ip_address

    validates_presence_of :tax_id_number
    validates_presence_of :is_mailing_address_foreign
    validates_presence_of :is_person
    validates_presence_of :is_cip_satisfied
    validates_presence_of :created_by_ip_address

    validates_length_of :tax_id_number, :maximum => 9
    validates_length_of :tax_id_number, :minimum => 9
    validates_length_of :first_name, :maximum => 50
    validates_length_of :middle_name, :maximum => 50
    validates_length_of :last_name, :maximum => 50
    validates_length_of :name, :maximum => 150
    validates_length_of :mailing_address_1, :maximum => 40
    validates_length_of :mailing_address_2, :maximum => 40
    validates_length_of :mailing_city, :maximum => 40
    validates_length_of :mailing_state, :maximum => 30
    validates_length_of :mailing_zip, :maximum => 9
    validates_length_of :mailing_country, :maximum => 40
    validates_length_of :legal_address_1, :maximum => 40
    validates_length_of :legal_address_2, :maximum => 40
    validates_length_of :legal_city, :maximum => 40
    validates_length_of :legal_state, :maximum => 30
    validates_length_of :legal_zip, :maximum => 9
    validates_length_of :legal_country, :maximum => 40
    validates_length_of :primary_phone, :maximum => 10
    validates_length_of :secondary_phone, :maximum => 10
    validates_length_of :email, :maximum => 50
    validates_length_of :portal_investor_number, :maximum => 30
    validates_length_of :created_by_ip_address, :maximum => 25

    def self.find(id)
      url = "Crowdfunding/api/Investor/#{id}"
      response = get(url)
      parse(response)
    end

    def self.create(data)
      url = "Crowdfunding/api/Investor"
      response = post(url, data)
      parse(response)
    end
  end
end
