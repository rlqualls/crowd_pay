module CrowdPay
  class Escrow
    include ActiveModel::AttributeMethods
    include ActiveModel::Validations
    include CrowdPay::Base

    attr_accessor :id, :issue_number, :portal_issue_number, :offering_type, :minimum_investment_amount, :maximum_investment_amount, :issue_amount, :cash_balance, :principal_balance, :date, :description, :amount, :status, :transactions

    def self.find(id=nil)
      url = 'Crowdfunding/api/Escrows'
      url += "/#{id}" if id
      response = get(url)
      parse(response)
    end

    def self.find_with_transactions(id)
      url = "Crowdfunding/api/Escrows/#{id}/Transactions"
      response = get(url)
      parse(response)
    end
  end
end
