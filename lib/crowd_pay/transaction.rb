module CrowdPay
  class Transaction

    include ActiveModel::AttributeMethods
    include ActiveModel::Validations
    include CrowdPay::Base

    attr_accessor :id, :account_id, :asset_id, :date, :reference, :description, :amount, :status, :effective_date, :maturity_date, :cusip_number, :created_by_ip_address

    validates_presence_of :account_id
    validates_presence_of :amount
    validates_presence_of :created_by_ip_address
    validates_length_of :reference, :maximum => 20
    validates_length_of :description, :maximum => 50
    validates_length_of :created_by_ip_address, :maximum => 25

    def self.find(account_id, id)
      url = "Crowdfunding/api/Account/#{account_id}/Transaction/#{id}"
      response = get(url)
      parse(response)
    end

    def self.withdraw_funds(data)
      url = "Crowdfunding/api/Account/#{data[:account_id]}/Transaction/WithdrawFunds"
      response = post(url, data)
      parse(response)
    end

    def self.fund_debt_escrow(data)
      url = "Crowdfunding/api/Account/#{data[:account_id]}/Transaction/FundDebtEscrow"
      response = post(url, data)
      parse(response)
    end

    def self.fund_account(data)
      url = "Crowdfunding/api/Account/#{data[:account_id]}/Transaction/FundAccount"
      response = post(url, data)
      parse(response)
    end

    def self.debt_pay(data)
      url = "Crowdfunding/api/Account/#{data[:account_id]}/Transaction/DebtPay"
      response = post(url, data)
      parse(response)
    end

    def self.reinvest_debt(data)
      url = "Crowdfunding/api/Account/#{data[:account_id]}/Transaction/ReinvestDebt"
      response = post(url, data)
      parse(response)
    end
  end
end
