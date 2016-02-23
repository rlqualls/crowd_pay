FactoryGirl.define do
  factory :account, class: CrowdPay::Account do |a|
    a.portal_account_number "youraccountnumber"
    a.investor_id 78548
    a.name_1 nil
    a.name_2 nil
    a.name_3 nil
    a.name_4 nil
    a.mailing_address_1 "123 Ave A"
    a.mailing_address_2 nil
    a.mailing_city "Somewhere"
    a.mailing_state "TX"
    a.mailing_zip "79109"
    a.mailing_country nil
    a.is_mailing_address_foreign "true"
    a.is_cip_satisfied "true"
    a.draft_account_type_id 1
    a.draft_routing_number "111310870"
    a.draft_account_number "1234567890"
    a.draft_account_name "First Last"
    a.status_id 1
    a.account_type_id 12
    a.w9_code_id 1
    a.contact_name "InvestorFirst InvestorLast"
    a.contact_phone "8061234567"
    a.contact_email "fi+rst.l+ast@somewhere.com"
    a.idology_id 123456
    a.created_by_ip_address '182.156.77.154'
  end

  trait :with_assets do
    after(:build) do |account|
      account.assets = [FactoryGirl.build(:asset)]
    end
  end

  trait :with_transactions do
    after(:build) do |account|
      account.transactions = [FactoryGirl.build(:transaction)]
    end
  end
end
