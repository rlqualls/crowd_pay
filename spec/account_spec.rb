require "spec_helper"

describe CrowdPay::Account do

  let(:account) { FactoryGirl.build(:account) }

  context "validate factories" do
    it "should validate the account factories" do
      expect(account).to be_valid
    end
  end

  context "Validations" do

    it "investor_id presence" do
      account.investor_id = nil
      expect(account).to be_invalid
    end

    it "is_mailing_address_foreign presence" do
      account.is_mailing_address_foreign = nil
      expect(account).to be_invalid
    end

    it "is_cip_satisfied presence" do
      account.is_cip_satisfied = nil
      expect(account).to be_invalid
    end


    it "status_id presence" do
      account.status_id = nil
      expect(account).to be_invalid
    end

    it "account_type_id presence" do
      account.account_type_id = nil
      expect(account).to be_invalid
    end

    it "draft_account_type_id presence" do
      account.draft_account_type_id = nil
      expect(account).to be_invalid
    end

    it "draft_routing_number presence" do
      account.draft_routing_number = nil
      expect(account).to be_invalid
    end

    it "draft_account_number presence" do
      account.draft_account_number = nil
      expect(account).to be_invalid
    end

    it "draft_account_name presence" do
      account.draft_account_name = nil
      expect(account).to be_invalid
    end

    it "created_by_ip_address presence" do
      account.created_by_ip_address = nil
      expect(account).to be_invalid
    end

    it "w9_code_id presence" do
      account.w9_code_id = nil
      expect(account).to be_invalid
    end


    it "maximum lenth of portal_account_number" do
      account.portal_account_number = "32424324354544523674523645345345"
      expect(account).to be_invalid
    end

    it "maximum lenth of name_1" do
      account.name_1 = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs"
      expect(account).to be_invalid
    end

    it "maximum lenth of name_2" do
      account.name_2 = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs"
      expect(account).to be_invalid
    end

    it "maximum lenth of name_3" do
      account.name_3 = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs"
      expect(account).to be_invalid
    end

    it "maximum lenth of name_4" do
      account.name_4 = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs"
      expect(account).to be_invalid
    end

    it "maximum lenth of mailing_address_1" do
      account.mailing_address_1 = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf"
      expect(account).to be_invalid
    end

    it "maximum lenth of mailing_address_2" do
      account.mailing_address_2 = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf"
      expect(account).to be_invalid
    end

    it "maximum lenth of mailing_city" do
      account.mailing_city = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf"
      expect(account).to be_invalid
    end

    it "maximum lenth of mailing_state" do
      account.mailing_state = "adsdsdsdsq dfdsfdsfds fdsfdfsdfq"
      expect(account).to be_invalid
    end

    it "maximum lenth of mailing_zip" do
      account.mailing_zip = "abthiendjk"
      expect(account).to be_invalid
    end

    it "maximum lenth of mailing_country" do
      account.mailing_country = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf"
      expect(account).to be_invalid
    end

    it "maximum lenth of draft_account_type_id" do
      account.draft_routing_number = "12345678911"
      expect(account).to be_invalid
    end

    it "maximum lenth of draft_account_number" do
      account.draft_account_number = "1234567890123456789"
      expect(account).to be_invalid
    end

    it "maximum lenth of draft_account_name" do
      account.draft_account_name = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs"
      expect(account).to be_invalid
    end

    it "maximum lenth of contact_name" do
      account.contact_name = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs fdsfsdfdfs fdsfsdfdfs fdsfsdfdfs fdsfsdfdfs"
      expect(account).to be_invalid
    end

    it "maximum lenth of contact_phone" do
      account.contact_phone = "123456789012345678911"
      expect(account).to be_invalid
    end

    it "maximum lenth of contact_email" do
      account.contact_email = "sadasdasdsavxcvcx@fdsfdsfdsfgdfgtreter.dsfdsfdsfdsfds"
      expect(account).to be_invalid
    end

    it "maximum lenth of created_by_ip_address" do
      account.created_by_ip_address = "123.4567.891.23456.789123456789"
      expect(account).to be_invalid
    end
  end

  context "create" do
    context "positive case" do
      it "should create a new account" do
        url = "https://test.crowdpay.com/Crowdfunding/api/Account"
        account_attributes = FactoryGirl.attributes_for(:account)
        stub_request(:post, url).to_return(:status => 201, :body => "{\"id\":82980,\"number\":\"$1000605486\",\"portal_account_number\":\"youraccountnumber\",\"investor_id\":78548,\"name_1\":\"InvestorFirst InvestorMiddle InvestorLast\",\"name_2\":null,\"name_3\":null,\"name_4\":null,\"mailing_address_1\":\"123 Ave A\",\"mailing_address_2\":null,\"mailing_city\":\"Somewhere\",\"mailing_state\":\"TX\",\"mailing_zip\":\"79109\",\"mailing_country\":null,\"is_mailing_address_foreign\":true,\"available_balance\":0.00,\"current_balance\":0.00,\"is_cip_satisfied\":false,\"draft_account_type_id\":1,\"draft_routing_number\":\"*****0870\",\"draft_account_number\":\"******7890\",\"draft_account_name\":\"First Last\",\"status_id\":1,\"account_type_id\":12,\"w9_code_id\":1,\"contact_name\":\"InvestorFirst InvestorLast\",\"contact_phone\":\"8061234567\",\"contact_email\":\"fi+rst.l+ast@somewhere.com\",\"idology_id\":123456,\"created_by_ip_address\":\"192.168.2.126\",\"Assets\":[],\"Transactions\":[]}")
        account = CrowdPay::Account.create(account_attributes)
        expect(account).to be_an(CrowdPay::Account)
        expect(account.assets).to eq([])
        expect(account.transactions).to eq([])
      end
    end

    context "negative case" do
      it "should not create a new account" do
        url = "https://test.crowdpay.com/Crowdfunding/api/Account"
        stub_request(:post, url).to_return(:status => 400, :body => "{\"Message\":\"The request is invalid.\",\"ModelState\":{\"account\":[\"An error has occurred.\",\"An error has occurred.\",\"An error has occurred.\"],\"account.draft_account_type_id \":[\"The draft_account_type_id field is required.\"],\"account.draft_routing_number \":[\"The draft_routing_number field is required.\"],\" account.draft_account_number \":[\"The draft_account_number field is required.\"], \"account. draft_account_name \":[\"The draft_account_name field is required.\"], \"account. status_id \":[\"The field status_id must match the regular expression '[1-3]'.\"], \"account. account_type_id \":[\"The field account_type_id must match the regular expression '[2]|1[1-2]'.\"], \"account. created_by_ip_address \":[\"The created_by_ip_address field is required.\"]}}")
        account = CrowdPay::Account.create({})
        expect(account).to be_an(CrowdPay::Account)
        # expect(account.errors["draft_account_type_id"]).to eq(["The draft_account_type_id field is required."])
        # expect(account.errors["draft_routing_number"]).to eq(["The draft_routing_number field is required."])
        # expect(account.errors["draft_account_number"]).to eq(["The draft_account_number field is required."])
        # expect(account.errors["draft_account_name"]).to eq(["The draft_account_name field is required."])
        # expect(account.errors["status_id"]).to eq(["The field status_id must match the regular expression '[1-3]'."])
        # expect(account.errors["account_type_id"]).to eq(["The field account_type_id must match the regular expression '[2]|1[1-2]'."])
        # expect(account.errors["created_by_ip_address"]).to eq(["The created_by_ip_address field is required."])
      end
    end
  end

  context "find" do
    context "positive case" do
      it "should get an account with id" do
        account_id = "82980"
        stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}").to_return(:status => 200, :body => "{\"id\":78627,\"investor_key\":\"a3cda761-78ff-4789-84fb-80a35628f95e\",\"tax_id_number\":\"*****8718\",\"first_name\":\"Investor First\",\"middle_name\":\"Investor Middle\",\"last_name\":\"Investor Last\",\"name\":\"Investor First Investor Middle Investor Last\",\"birth_date\":\"1985-04-07T00:00:00\",\"mailing_address_1\":\"123 Ave A\",\"mailing_address_2\":null,\"mailing_city\":\"Somewhere\",\"mailing_state\":\"TX\",\"mailing_zip\":\"79109\",\"mailing_country\":null,\"is_mailing_address_foreign\":false,\"legal_address_1\":\"123 Ave A\",\"legal_address_2\":null,\"legal_city\":\"Somewhere\",\"legal_state\":\"TX\",\"legal_zip\":\"79109\",\"legal_country\":null,\"is_legal_address_foreign\":false,\"primary_phone\":\"1112223333\",\"secondary_phone\":\"2223334444\",\"is_person\":true,\"email\":\"cgrimes@qwinixtech.com\",\"is_cip_satisfied\":false,\"portal_investor_number\":\"yourinvestornumber\",\"created_by_ip_address\":\"192.168.2.61\",\"Assets\":[]}")
        account = CrowdPay::Account.find(account_id)
        expect(account).to be_an(CrowdPay::Account)
      end

      it "should get an account with id along with assets and transactions" do
        account_id = "82980"
        stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}").to_return(:status => 200, :body => "{\"id\":78627,\"investor_key\":\"a3cda761-78ff-4789-84fb-80a35628f95e\",\"tax_id_number\":\"*****8718\",\"first_name\":\"Investor First\",\"middle_name\":\"Investor Middle\",\"last_name\":\"Investor Last\",\"name\":\"Investor First Investor Middle Investor Last\",\"birth_date\":\"1985-04-07T00:00:00\",\"mailing_address_1\":\"123 Ave A\",\"mailing_address_2\":null,\"mailing_city\":\"Somewhere\",\"mailing_state\":\"TX\",\"mailing_zip\":\"79109\",\"mailing_country\":null,\"is_mailing_address_foreign\":false,\"legal_address_1\":\"123 Ave A\",\"legal_address_2\":null,\"legal_city\":\"Somewhere\",\"legal_state\":\"TX\",\"legal_zip\":\"79109\",\"legal_country\":null,\"is_legal_address_foreign\":false,\"primary_phone\":\"1112223333\",\"secondary_phone\":\"2223334444\",\"is_person\":true,\"email\":\"cgrimes@qwinixtech.com\",\"is_cip_satisfied\":false,\"portal_investor_number\":\"yourinvestornumber\",\"created_by_ip_address\":\"192.168.2.61\",\"Assets\":[{\"id\":471277,\"description\":\"ACME Wealth Agriculture 101, LLC\",\"number\":\"2000001\",\"sold_date\":null,\"market_value\":250,\"Transactions\":[]}],\"Transactions\":[{\"id\":681354,\"account_id\":81690,\"asset_id\":null,\"date\":\"2015-01-02T00:00:00\",\"reference\":\"ref123\",\"description\":\"Cash Deposit\",\"amount\":5000,\"status\":\"Processed\",\"created_by_ip_address\":\"123.456.789.012\"}]}")
        account = CrowdPay::Account.find(account_id)
        expect(account).to be_an(CrowdPay::Account)
        expect(account.assets.count).to be(1)
      end
    end

    context "negative case" do
      it "should return an account object with errors in it if account_id is invalid" do
        account_id = "invalid_account_id"
        stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}").to_return(:status => 405, :body => "{\"Message\":\"The requested resource does not support http method 'GET'.\"}")
        account = CrowdPay::Account.find(account_id)
        expect(account).to be_an(CrowdPay::Account)
        expect(account.errors[:api]).to eq(["The requested resource does not support http method 'GET'."])
      end
    end
  end

  context "get account with Transaction" do
    context "positive case" do
      it "should get transaction with account" do
        account_id = "83017"
        url = "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}/Transaction"
        stub_request(:get, url).to_return(:status => 200, :body => "{\"id\":9876544,\"number\":\"$1000605486\",\"portal_account_number\":\"youraccountnumber\",\"investor_id\":78548,\"name_1\":\"InvestorFirst InvestorMiddle InvestorLast\",\"name_2\":null,\"name_3\":null,\"name_4\":null,\"mailing_address_1\":\"123 Ave A\",\"mailing_address_2\":null,\"mailing_city\":\"Somewhere\",\"mailing_state\":\"TX\",\"mailing_zip\":\"79109\",\"mailing_country\":null,\"is_mailing_address_foreign\":true,\"available_balance\":0.00,\"current_balance\":0.00,\"is_cip_satisfied\":false,\"draft_account_type_id\":1,\"draft_routing_number\":\"*****0870\",\"draft_account_number\":\"******7890\",\"draft_account_name\":\"First Last\",\"status_id\":1,\"account_type_id\":12,\"w9_code_id\":1,\"contact_name\":\"InvestorFirst InvestorLast\",\"contact_phone\":\"8061234567\",\"contact_email\":\"fi+rst.l+ast@somewhere.com\",\"idology_id\":123456,\"created_by_ip_address\":\"192.168.2.126\",\"Assets\":[],\"Transactions\":[]}")
        account_with_transaction = CrowdPay::Account.find_with_transactions(account_id)
        expect(account_with_transaction).to be_an(CrowdPay::Account)
      end
    end

    context "negative case" do
      it "should not get transaction with account" do
        account_id = "83017"
        url = "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}/Transaction"
        stub_request(:get, url).to_return(:status => 405, :body => "{\"Message\":\"The requested resource does not support http method 'GET'.\"}")
        account_with_transaction = CrowdPay::Account.find_with_transactions(account_id)
        expect(account_with_transaction).to be_an(CrowdPay::Account)
      end
    end
  end

  context "update account" do
    context "positive case" do
      it "should update  account" do
        account_id = "83017"
        url = "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}"
        account_attributes = FactoryGirl.attributes_for(:account)
        stub_request(:put, url).to_return(:status => 200, :body => "{\"id\":82980,\"number\":\"$1000605486\",\"portal_account_number\":\"youraccountnumber\",\"investor_id\":78548,\"name_1\":\"InvestorFirst InvestorMiddle InvestorLast\",\"name_2\":null,\"name_3\":null,\"name_4\":null,\"mailing_address_1\":\"prakash\",\"mailing_address_2\":null,\"mailing_city\":\"Somewhere\",\"mailing_state\":\"TX\",\"mailing_zip\":\"79109\",\"mailing_country\":null,\"is_mailing_address_foreign\":true,\"available_balance\":0.00,\"current_balance\":0.00,\"is_cip_satisfied\":false,\"draft_account_type_id\":1,\"draft_routing_number\":\"*****0870\",\"draft_account_number\":\"******7890\",\"draft_account_name\":\"First Last\",\"status_id\":1,\"account_type_id\":12,\"w9_code_id\":1,\"contact_name\":\"InvestorFirst InvestorLast\",\"contact_phone\":\"8061234567\",\"contact_email\":\"fi+rst.l+ast@somewhere.com\",\"idology_id\":123456,\"created_by_ip_address\":\"192.168.2.126\",\"Assets\":[],\"Transactions\":[]}")
        update_account = CrowdPay::Account.update(account_id, account_attributes)
        expect(update_account).to be_an(CrowdPay::Account)
      end
    end

    context "negative case" do
      it "should not update account" do
        account_id = "invalid_account_id"
        url = "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}"
        account_attributes = FactoryGirl.attributes_for(:account)
        stub_request(:put, url).to_return(:status => 405, :body => "{\"Message\":\"The requested resource does not support http method 'put'.\"}")
        update_account = CrowdPay::Account.update(account_id, {})
        expect(update_account).to be_an(CrowdPay::Account)
      end
    end
  end

  context "get_all_assets" do
    context "positive case" do
      it "should get all assets" do
        account_id = "82980"
        stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/V2/Account/#{account_id}/Assets/All").to_return(:status => 200, :body => "{\"id\":82980,\"number\":\"$1000605486\",\"portal_account_number\":\"youraccountnumber\",\"investor_id\":78548,\"name_1\":\"InvestorFirst InvestorMiddle InvestorLast\",\"name_2\":null,\"name_3\":null,\"name_4\":null,\"mailing_address_1\":\"prakash\",\"mailing_address_2\":null,\"mailing_city\":\"Somewhere\",\"mailing_state\":\"TX\",\"mailing_zip\":\"79109\",\"mailing_country\":null,\"is_mailing_address_foreign\":true,\"available_balance\":0.00,\"current_balance\":0.00,\"is_cip_satisfied\":false,\"draft_account_type_id\":1,\"draft_routing_number\":\"*****0870\",\"draft_account_number\":\"******7890\",\"draft_account_name\":\"First Last\",\"status_id\":1,\"account_type_id\":12,\"w9_code_id\":1,\"contact_name\":\"InvestorFirst InvestorLast\",\"contact_phone\":\"8061234567\",\"contact_email\":\"fi+rst.l+ast@somewhere.com\",\"idology_id\":123456,\"created_by_ip_address\":\"192.168.2.126\",\"Assets\":[{\"id\":471277,\"description\":\"ACME Wealth Agriculture 101, LLC\",\"number\":\"2000001\",\"sold_date\":\"null\",\"market_value\":\"250\",\"Transactions\":[]}]}")
        asset = CrowdPay::Account.find_with_assets(account_id).assets.first
        expect(asset).to be_an(CrowdPay::Asset)
      end
    end

    context "negative case" do
      it "should not get asset" do
        account_id = "invalid_account_id"
        stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/V2/Account/#{account_id}/Assets/All").to_return(:status => 405, :body => "{\"Message\":\"The requested resource does not support http method 'GET'.\"}")
        asset = CrowdPay::Account.find_with_assets(account_id).assets
        expect(asset).to eq(nil)
      end
    end
  end
end
