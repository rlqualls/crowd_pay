module CrowdPay
  class Asset
    include ActiveModel::AttributeMethods
    include ActiveModel::Validations
    include CrowdPay::Base

    register_association :transactions, class_name: "CrowdPay::Transaction"

    attr_accessor :term, :effective_date, :interest_type, :interest_frequency,
      :interest_rate, :maturity_date, :third_party_asset_number, :quantity,
      :cusip_number, :id, :description, :number, :sold_date, :market_value,
      :cost_basis, :created_by_ip_address

    def self.find(account_id, id)
      url = "Crowdfunding/api/Account/#{account_id}/Assets/#{id}"
      response = get(url)
      parse(response)
    end

    def self.find_with_transactions(account_id, id)
      url = "Crowdfunding/api/Account/#{account_id}/Assets/#{id}/Transactions"
      response = get(url)
      parse(response)
    end
  end
end
