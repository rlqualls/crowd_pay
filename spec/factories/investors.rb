FactoryGirl.define do
  factory :investor, :class => CrowdPay::Investor do |i|
    i.tax_id_number { s = Time.now.to_i.to_s; s[0] = ''; s; }
    i.first_name "Investor First"
    i.middle_name "Investor Middle"
    i.last_name "Investor Last"
    i.name nil
    i.birth_date Date.today() - 30.years
    i.mailing_address_1 "123 Ave A"
    i.mailing_address_2 nil
    i.mailing_city "Somewhere"
    i.mailing_state "TX"
    i.mailing_zip "79109"
    i.mailing_country nil
    i.is_mailing_address_foreign "false"
    i.legal_address_1 "123 Ave A"
    i.legal_address_2 nil
    i.legal_city "Somewhere"
    i.legal_state "TX"
    i.legal_zip "79109"
    i.legal_country nil
    i.is_legal_address_foreign "false"
    i.primary_phone "1112223333"
    i.secondary_phone "2223334444"
    i.is_person "true"
    i.email "cgrimes@qwinixtech.com"
    i.is_cip_satisfied "false"
    i.portal_investor_number "yourinvestornumber"
    i.created_by_ip_address '182.156.77.154'
  end
end
