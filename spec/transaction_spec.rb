require "spec_helper"

describe "CrowdPay::Investor" do
let(:transaction) { FactoryGirl.build(:transaction) }

  context "validate factories" do
    it "should validate the transaction factories" do
      expect(transaction.valid?).to be(true)
    end
  end

  context "Validations" do

    it "account_id presence" do
      transaction.account_id = nil
      expect(transaction).to be_invalid
    end

    it "amount presence" do
      transaction.amount = nil
      expect(transaction).to be_invalid
    end

    it "created_by_ip_address presence" do
      transaction.created_by_ip_address = nil
      expect(transaction).to be_invalid
    end

    it "maximum length of reference" do
      transaction.reference = "anthskut thanks thsmk"
      expect(transaction).to be_invalid
    end

    it "maximum length of description" do
      transaction.description = "qwuhtndkl ethrindks thinekmdh thnmildhf thimfnghbcaml"
      expect(transaction).to be_invalid
    end

    it "maximum length of created_by_ip_address" do
      transaction.created_by_ip_address = "123.456789.12345678.123456"
      expect(transaction).to be_invalid
    end

  end

  context "find" do
    it "should get an transaction with id" do
      account_id = "82980"
      id = "6829651"
      stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}/Transaction/#{id}").to_return(:status => 200, :body => "{\"id\":6829651,\"account_id\":\"#{account_id}\",\"date\":\"#{Date.today}\",\"reference\":\"Reffernce\",\"amount\":100.0,\"status\":\"pending\",\"created_by_ip_address\":\"192.168.2.61\"}")
      transaction = CrowdPay::Transaction.find(account_id, id)
      expect(transaction).to be_an(CrowdPay::Transaction)
    end

    it "should get an transaction without id" do
      account_id = "82980"
      id = ""
      stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}/Transaction/#{id}").to_return(:status => 200, :body => "{\"Message\":\"The requested resource does not support http method 'GET'.\"}")
      transaction = CrowdPay::Transaction.find(account_id, id)
      expect(transaction).to be_an(CrowdPay::Transaction)
    end
  end

  context "withdraw_fund" do
    it "should create withdraw transaction" do
      account_id = "82980"
      id = "6829651"
      trasaction_data = FactoryGirl.attributes_for(:transaction, account_id: account_id, id: id)
      stub_request(:post, "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}/Transaction/WithdrawFunds").to_return(:status => 200, :body => "{\"id\":78627,\"account_id\":\"#{account_id}\",\"date\":\"#{Date.today}\",\"reference\":\"Reffernce\",\"amount\":100.0,\"status\":\"pending\",\"created_by_ip_address\":\"192.168.2.61\"}")
      transaction = CrowdPay::Transaction.withdraw_funds(trasaction_data)
      expect(transaction).to be_an(CrowdPay::Transaction)
    end
  end

  context "create fund escrow" do
    context "positive case" do
      it "should create a new found escrow" do
        account_id = "82980"
        url = "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}/Transaction/FundDebtEscrow"
        account_attributes = FactoryGirl.attributes_for(:account, account_id: account_id)
        stub_request(:post, url).to_return(:status => 201, :body => "{\"id\":82980,\"account_id\":\"#{account_id}\",\"asset_id\":\"456789\",\"date\":\"2015-01-01T00:00:00\",\"reference\":\"yourreferencenumber\",\"description\":\"description you would like placed on transaction\",\"amount\":\"100.00\",\"quantity\":\"10\",\"created_by_ip_address\":\"123.456.789.012\"}")
        transaction_obj = CrowdPay::Transaction.fund_debt_escrow(account_attributes)
        expect(transaction_obj).to be_an(CrowdPay::Transaction)
      end
    end

    context "negative case" do
      it "should not create a new found escrow" do
        account_id = "82980"
        url = "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}/Transaction/FundDebtEscrow"
        stub_request(:post, url).to_return(:status => 400, :body => "{\"Message\":\"The request is invalid.\",\"ModelState\":{\"account\":[\"An error has occurred.\",\"An error has occurred.\",\"An error has occurred.\"],\"account.draft_account_type_id \":[\"The draft_account_type_id field is required.\"],\"account.draft_routing_number \":[\"The draft_routing_number field is required.\"],\" account.draft_account_number \":[\"The draft_account_number field is required.\"], \"account. draft_account_name \":[\"The draft_account_name field is required.\"], \"account. status_id \":[\"The field status_id must match the regular expression '[1-3]'.\"], \"account. account_type_id \":[\"The field account_type_id must match the regular expression '[2]|1[1-2]'.\"], \"account. created_by_ip_address \":[\"The created_by_ip_address field is required.\"]}}")
        transaction_obj = CrowdPay::Transaction.fund_debt_escrow(account_id: account_id)
        expect(transaction_obj).to be_an(CrowdPay::Transaction)
      end
    end
  end

  context "create fund account" do
    context "positive case" do
      it "should create a new fund account" do
        account_id = "82980"
        url = "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}/Transaction/FundAccount"
        account_attributes = FactoryGirl.attributes_for(:account, account_id: account_id)
        stub_request(:post, url).to_return(:status => 201, :body => "{\"id\":9876544,\"account_id\":\"#{account_id}\",\"date\":\"2015-01-01T00:00:00\",\"reference\":\"yourreferencenumber\",\"description\":\"description you would like placed on transaction\",\"amount\":\"100.00\",\"created_by_ip_address\":\"123.456.789.012\"}")
        transaction_obj = CrowdPay::Transaction.fund_account(account_attributes)
        expect(transaction_obj).to be_an(CrowdPay::Transaction)
      end
    end

    context "negative case" do
      it "should not create a new fund account" do
        account_id = "82980"
        url = "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}/Transaction/FundAccount"
        stub_request(:post, url).to_return(:status => 400, :body => "{\"Message\":\"The request is invalid.\",\"ModelState\":{\"account\":[\"An error has occurred.\",\"An error has occurred.\",\"An error has occurred.\"],\"account.draft_account_type_id \":[\"The draft_account_type_id field is required.\"],\"account.draft_routing_number \":[\"The draft_routing_number field is required.\"],\" account.draft_account_number \":[\"The draft_account_number field is required.\"], \"account. draft_account_name \":[\"The draft_account_name field is required.\"], \"account. status_id \":[\"The field status_id must match the regular expression '[1-3]'.\"], \"account. account_type_id \":[\"The field account_type_id must match the regular expression '[2]|1[1-2]'.\"], \"account. created_by_ip_address \":[\"The created_by_ip_address field is required.\"]}}")
        transaction_obj = CrowdPay::Transaction.fund_account(account_id: account_id)
        expect(transaction_obj).to be_an(CrowdPay::Transaction)
      end
    end
  end

    context "create debt pay" do
    context "positive case" do
      it "should create a new debt pay" do
        debt_data = { account_id: "82980", asset_id: "471922", activity_code: "305", sold_date: nil,
        reference: 'IntPaid', description: 'CrowdPay: Debt Pay Post Interest', amount: "100.00", created_by_ip_address: '182.156.77.154'
      }
        url = "https://test.crowdpay.com/Crowdfunding/api/Account/#{debt_data[:account_id]}/Transaction/DebtPay"
        stub_request(:post, url)
        .to_return(status: 201, body: "{\"id\":6580369,\"account_id\":\"#{debt_data[:account_id]}\",\"sold_date\":\"2015-01-01T00:00:00\",\"asset_id\":\"#{debt_data[:asset_id]}\",\"activity_code\":\"305\",\"status\":\"pending\",\"reference\":\"yourreferencenumber\",\"description\":\"description you would like placed on transaction\",\"amount\":\"100.00\",\"created_by_ip_address\":\"123.456.789.012\"}")
        transaction_obj = CrowdPay::Transaction.debt_pay(debt_data)
        expect(transaction_obj).to be_an(CrowdPay::Transaction)
      end
    end

    context "negative case" do
      it "should not create a new debt pay" do
        debt_data = { account_id: "82980", asset_id: "471922" }
        url = "https://test.crowdpay.com/Crowdfunding/api/Account/#{debt_data[:account_id]}/Transaction/DebtPay"
        stub_request(:post, url)
        .to_return(:status => 400, :body => "{\"Message\":\"The request is invalid.\",\"ModelState\":{\"account\":[\"An error has occurred.\",\"An error has occurred.\",\"An error has occurred.\"],\"account.activity_code \":[\"The activity_code field is required.\"],\"account. created_by_ip_address \":[\"The created_by_ip_address field is required.\"]}}")
        transaction_obj = CrowdPay::Transaction.debt_pay(debt_data)
        expect(transaction_obj).to be_an(CrowdPay::Transaction)
      end
    end
  end

    context "create Reinvest Debt" do
    context "positive case" do
      it "should create a new reinvest debt" do
        reinvest_data = { account_id: "82980", asset_id: "471922", activity_code: "707", sold_date: nil,
          reference: "yourreferencenumber", description: "description you would like placed on transaction",
          amount: "100.00", quantity: 1, created_by_ip_address: "182.156.77.154", term: 3.0,
          effective_date: "2015-01-15T00:00:00", interest_type: 1, interest_frequency: 4, interest_rate: 1.0,
          maturity_date: "2018-07-15T00:00:00", third_party_asset_number:34, asset_description:"Community Investment Note", cusip_number:"3213243244"
        }
        url = "https://test.crowdpay.com/Crowdfunding/api/Account/#{reinvest_data[:account_id]}/Transaction/ReinvestDebt"

        stub_request(:post, url).to_return(status: 201, body: "{\"id\":1223344,\"account_id\":\"82980\",\"sold_date\":null,\"asset_id\":\"471922\",\"activity_code\":\"707\",\"status\":\"pending\",\"reference\":\"yourreferencenumber\",\"description\":\"description you would like placed on transaction\",\"amount\":\"100.00\",\"quantity\":1,\"term\":3.0,\"effective_date\":\"2015-01-15T00:00:00\",\"interest_type\":1,\"interest_frequency\":4,\"interest_rate\":1.50,\"maturity_date\":\"2018-07-15T00:00:00\",\"third_party_asset_number\":\"yourassetnumber\",\"asset_description\":\"custom asset description\",\"cusip_number\":\"1315020180115\",\"status\":\"pending\",\"created_by_ip_address\":\"123.456.789.012\"}")

        transaction_obj = CrowdPay::Transaction.reinvest_debt(reinvest_data)
        expect(transaction_obj).to be_an(CrowdPay::Transaction)
      end
    end

    context "negative case" do
      it "should not create a new reinvest debt" do
        account_id = "82980"
        reinvest_data = {account_id: "82980", asset_id: "471922"}
        url = "https://test.crowdpay.com/Crowdfunding/api/Account/#{reinvest_data[:account_id]}/Transaction/ReinvestDebt"
        stub_request(:post, url).to_return(:status => 400, :body => "{\"Message\":\"The request is invalid.\",\"ModelState\":{\"account\":[\"An error has occurred.\",\"An error has occurred.\",\"An error has occurred.\"],\"account.activity_code \":[\"The activity_code field is required.\"],\"account. created_by_ip_address \":[\"The created_by_ip_address field is required.\"]}}")
        transaction_obj = CrowdPay::Transaction.reinvest_debt(reinvest_data)
        expect(transaction_obj).to be_an(CrowdPay::Transaction)
      end
    end
  end
end