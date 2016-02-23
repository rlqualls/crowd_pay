FactoryGirl.define do
  factory :asset, class: CrowdPay::Asset do |as|
    as.id 471277
    as.description "ACME Wealth Agriculture 101, LLC"
    as.number "2000001"
    as.sold_date nil
    as.market_value 250
    as.created_by_ip_address '182.156.77.154'
  end
end
