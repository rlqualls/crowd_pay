FactoryGirl.define do
  factory :escrow, class: CrowdPay::Escrow do |i|
    i.issue_number "2000009"
    i.portal_issue_number nil
    i.offering_type "Debt"
    i.minimum_investment_amount 20.0
    i.maximum_investment_amount 10000.0
    i.issue_amount 1000000
    i.cash_balance 200
    i.principal_balance 100
  end
end
