module CrowdPay
  class Account
    include ActiveModel::AttributeMethods
    include ActiveModel::Validations
    include CrowdPay::Base

    attr_accessor :id, :number, :portal_account_number, :investor_id,
                  :name_1, :name_2, :name_3, :name_4,
                  :mailing_address_1, :mailing_address_2, :mailing_city,
                  :mailing_state, :mailing_zip, :mailing_country,
                  :is_mailing_address_foreign, :is_cip_satisfied,
                  :draft_account_type_id, :draft_routing_number,
                  :draft_account_number, :draft_account_name, :status_id,
                  :account_type_id, :w9_code_id, :contact_name, :contact_phone,
                  :contact_email, :idology_id, :available_balance,
                  :current_balance, :created_by_ip_address



    register_association :assets, class_name: "CrowdPay::Asset"
    register_association :transactions, class_name: "CrowdPay::Transaction"

    validates_presence_of :investor_id
    validates_presence_of :status_id
    validates_presence_of :account_type_id
    validates_presence_of :is_mailing_address_foreign
    validates_presence_of :is_cip_satisfied
    validates_presence_of :draft_account_type_id
    validates_presence_of :draft_routing_number
    validates_presence_of :draft_account_number
    validates_presence_of :draft_account_name
    validates_presence_of :created_by_ip_address
    validates_presence_of :w9_code_id
    validates_length_of :portal_account_number, :maximum => 30
    validates_length_of :name_1, :maximum => 50
    validates_length_of :name_2, :maximum => 50
    validates_length_of :name_3, :maximum => 50
    validates_length_of :name_4, :maximum => 50
    validates_length_of :mailing_address_1, :maximum => 40
    validates_length_of :mailing_address_2, :maximum => 40
    validates_length_of :mailing_city, :maximum => 40
    validates_length_of :mailing_state, :maximum => 30
    validates_length_of :mailing_zip, :maximum => 9
    validates_length_of :mailing_country, :maximum => 40
    validates_length_of :draft_routing_number, :maximum => 9
    validates_length_of :draft_account_number, :maximum => 17
    validates_length_of :draft_account_name, :maximum => 50
    validates_length_of :contact_name, :maximum => 75
    validates_length_of :contact_phone, :maximum => 20
    validates_length_of :contact_email, :maximum => 50
    validates_length_of :created_by_ip_address, :maximum => 25

    def self.find(id)
      url = "Crowdfunding/api/Account/#{id}"
      response = get(url)
      parse(response)
    end

    def self.find_with_transactions(id)
      url = "Crowdfunding/api/Account/#{id}/Transaction"
      response = get(url)
      parse(response)
    end

    def self.create(data)
      url = "Crowdfunding/api/Account"
      response = post(url, data)
      parse(response)
    end

    def self.update(id, data)
      url = "Crowdfunding/api/Account/#{id}"
      response = put(url, data)
      parse(response)
    end

    def self.find_with_assets(account_id)
      url = "Crowdfunding/api/V2/Account/#{account_id}/Assets/All"
      response = get(url)
      parse(response)
    end
  end
end
