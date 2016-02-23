require "spec_helper"

describe "CrowdPay::Investor" do
let(:investor) { FactoryGirl.build(:investor) }

  context "validate factories" do
    it "should validate the investor factories" do
      expect(investor.valid?).to be(true)
    end
  end

  context "Validations" do
    it "tax_id_number presence" do
      investor.tax_id_number = nil
      expect(investor).to be_invalid
    end

    it "is_mailing_address_foreign presence" do
      investor.is_mailing_address_foreign = nil
      expect(investor).to be_invalid
    end

    it "is_person presence" do
      investor.is_person = nil
      expect(investor).to be_invalid
    end

    it "is_cip_satisfied presence" do
      investor.is_cip_satisfied = nil
      expect(investor).to be_invalid
    end

    it "created_by_ip_address presence" do
      investor.created_by_ip_address = nil
      expect(investor).to be_invalid
    end

    it "minmum lenth of tax_id_number" do
      investor.tax_id_number = "1234567"
      expect(investor).to be_invalid
    end

    it "maximum lenth of tax_id_number" do
      investor.tax_id_number = "1234567890"
      expect(investor).to be_invalid
    end

    it "maximum lenth of created_by_ip_address" do
      investor.created_by_ip_address = "32424324354544523674523645345345345345"
      expect(investor).to be_invalid
    end

    it "maximum lenth of first_name" do
      investor.first_name = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs fdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of middle_name" do
      investor.middle_name = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs fdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of last_name" do
      investor.last_name = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs fdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of name" do
      investor.name = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs fdsfdsf adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs fdsfdsf adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs fdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of mailing_address_1" do
      investor.mailing_address_1 = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs fdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of mailing_address_2" do
      investor.mailing_address_2 = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs fdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of mailing_city" do
      investor.mailing_city = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs fdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of mailing_state" do
      investor.mailing_state = "adsdsdsds dfdsfdsfds fdsfdfsdf fdsfdsfdsf fdsfsdfdfs fdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of mailing_zip" do
      investor.mailing_zip = "3242432435454"
      expect(investor).to be_invalid
    end

    it "maximum lenth of mailing_country" do
      investor.mailing_country = "ghgjhghbvzxbczx czxczxcbxzcxzcxzcxzczxsascsdsa dsfsfsdfdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of legal_address_1" do
      investor.legal_address_1 = "ghgjhghbvzxbczx czxczxcbxzcxzcxzcxzczxsascsdsa dsfsfsdfdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of legal_address_2" do
      investor.legal_address_2 = "ghgjhghbvzxbczx czxczxcbxzcxzcxzcxzczxsascsdsa dsfsfsdfdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of legal_city" do
      investor.legal_city = "ghgjhghbvzxbczx czxczxcbxzcxzcxzcxzczxsascsdsa dsfsfsdfdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of legal_state" do
      investor.legal_state = "ghgjhghbvzxbczx czxczxcbxzcxzcxzcxzczxsascsdsa"
      expect(investor).to be_invalid
    end

    it "maximum lenth of legal_zip" do
      investor.legal_zip = "3242432435454"
      expect(investor).to be_invalid
    end

    it "maximum lenth of legal_country" do
      investor.legal_country = "ghgjhghbvzxbczx czxczxcbxzcxzcxzcxzczxsascsdsa dsfsfsdfdsfdsf"
      expect(investor).to be_invalid
    end

    it "maximum lenth of primary_phone" do
      investor.primary_phone = "3242432435454"
      expect(investor).to be_invalid
    end

    it "maximum lenth of secondary_phone" do
      investor.secondary_phone = "3242432435454"
      expect(investor).to be_invalid
    end

    it "maximum lenth of email" do
      investor.email = "sadasdasdsavxcvcx@fdsfdsfdsfgdfgtreter.dsfdsfdsfdsfdsfdsvc"
      expect(investor).to be_invalid
    end

    it "maximum lenth of portal_investor_number" do
      investor.portal_investor_number = "32424324354544543534534534543534534535345435453"
      expect(investor).to be_invalid
    end
  end

  context "create" do
    context "positive case" do
      it "should create a new investor" do
        url = "https://test.crowdpay.com/Crowdfunding/api/Investor"
        investor_attributes = FactoryGirl.attributes_for(:investor)
        stub_request(:post, url).to_return(:status => 201, :body => "{\"id\":78630,\"investor_key\":\"9f3c734c-3a99-4a04-9d00-007f7497b6df\",\"tax_id_number\":\"*****2650\",\"first_name\":\"Investor First\",\"middle_name\":\"Investor Middle\",\"last_name\":\"Investor Last\",\"name\":null,\"birth_date\":\"1985-04-07T00:00:00\",\"mailing_address_1\":\"123 Ave A\",\"mailing_address_2\":null,\"mailing_city\":\"Somewhere\",\"mailing_state\":\"TX\",\"mailing_zip\":\"79109\",\"mailing_country\":null,\"is_mailing_address_foreign\":false,\"legal_address_1\":\"123 Ave A\",\"legal_address_2\":null,\"legal_city\":\"Somewhere\",\"legal_state\":\"TX\",\"legal_zip\":\"79109\",\"legal_country\":null,\"is_legal_address_foreign\":false,\"primary_phone\":\"1112223333\",\"secondary_phone\":\"2223334444\",\"is_person\":true,\"email\":\"cgrimes@qwinixtech.com\",\"is_cip_satisfied\":false,\"portal_investor_number\":\"yourinvestornumber\",\"created_by_ip_address\":\"192.168.2.61\",\"Accounts\":[]}")
        investor = CrowdPay::Investor.create(investor_attributes)
        expect(investor).to be_an(CrowdPay::Investor)
      end
    end

    context "negative case" do
      it "should not create a new investor" do
        url = "https://test.crowdpay.com/Crowdfunding/api/Investor"
        stub_request(:post, url).to_return(:status => 400, :body => "{\"Message\":\"The request is invalid.\",\"ModelState\":{\"investor\":[\"An error has occurred.\",\"An error has occurred.\",\"An error has occurred.\"],\"investor.tax_id_number\":[\"The tax_id_number field is required.\"],\"investor.created_by_ip_address\":[\"The created_by_ip_address field is required.\"]}}")
        investor = CrowdPay::Investor.create({})
        expect(investor).to be_an(CrowdPay::Investor)
        expect(investor.errors["tax_id_number"]).to eq(["The tax_id_number field is required."])
        expect(investor.errors["created_by_ip_address"]).to eq(["The created_by_ip_address field is required."])
      end
    end
  end

  context "find" do
    context "positive case" do
      it "should get an investor with id" do
        investor_key = "a3cda761-78ff-4789-84fb-80a35628f95e"
        stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/Investor/#{investor_key}").to_return(:status => 200, :body => "{\"id\":78627,\"investor_key\":\"a3cda761-78ff-4789-84fb-80a35628f95e\",\"tax_id_number\":\"*****8718\",\"first_name\":\"Investor First\",\"middle_name\":\"Investor Middle\",\"last_name\":\"Investor Last\",\"name\":\"Investor First Investor Middle Investor Last\",\"birth_date\":\"1985-04-07T00:00:00\",\"mailing_address_1\":\"123 Ave A\",\"mailing_address_2\":null,\"mailing_city\":\"Somewhere\",\"mailing_state\":\"TX\",\"mailing_zip\":\"79109\",\"mailing_country\":null,\"is_mailing_address_foreign\":false,\"legal_address_1\":\"123 Ave A\",\"legal_address_2\":null,\"legal_city\":\"Somewhere\",\"legal_state\":\"TX\",\"legal_zip\":\"79109\",\"legal_country\":null,\"is_legal_address_foreign\":false,\"primary_phone\":\"1112223333\",\"secondary_phone\":\"2223334444\",\"is_person\":true,\"email\":\"cgrimes@qwinixtech.com\",\"is_cip_satisfied\":false,\"portal_investor_number\":\"yourinvestornumber\",\"created_by_ip_address\":\"192.168.2.61\",\"Accounts\":[]}")
        investor2 = CrowdPay::Investor.find(investor_key)
        expect(investor2).to be_an(CrowdPay::Investor)
      end
    end

    context "negative case" do
      it "should return an investor object with errors in it if investor_key is invalid" do
        investor_key = "invalid_investor_key"
        stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/Investor/#{investor_key}").to_return(:status => 405, :body => "{\"Message\":\"The requested resource does not support http method 'GET'.\"}")
        investor = CrowdPay::Investor.find(investor_key)
        expect(investor).to be_an(CrowdPay::Investor)
        expect(investor.errors[:api]).to eq(["The requested resource does not support http method 'GET'."])
      end
    end
  end

end
