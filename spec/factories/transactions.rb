FactoryGirl.define do
  factory :transaction, class: CrowdPay::Transaction do |t|
    t.id 6829651
    t.account_id 81690
    t.asset_id 471277
    t.date "2015-01-02T00:00:00"
    t.reference "ref321"
    t.description "Purchase Assets"
    t.amount 250
    t.status "Pending"
    t.created_by_ip_address '182.156.77.154'
  end
end
