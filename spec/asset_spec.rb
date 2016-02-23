require 'spec_helper'

describe CrowdPay::Asset do

  context "validate factories" do
    it "should validate the asset factories" do
      asset = FactoryGirl.build(:asset)
      expect(asset.valid?).to be(true)
    end
  end

  context "get" do
    context "positive case" do
      it "should get asset with id" do
        account_id = "82980"
        id = "471277"
        stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}/Assets/#{id}").to_return(:status => 200, :body => "{\"id\":471277,\"description\":\"ACME Wealth Agriculture 101, LLC\",\"number\":\"2000001\",\"sold_date\":\"null\",\"market_value\":\"250\",\"Transactions\":[]}")
        asset = CrowdPay::Asset.find(account_id, id)
        expect(asset).to be_an(CrowdPay::Asset)
      end
    end

    context "negative case" do
      it "should not get asset with id" do
        account_id = "82980"
        id = "invalid_asset_id"
        stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/Account/#{account_id}/Assets/#{id}").to_return(:status => 405, :body => "{\"Message\":\"The requested resource does not support http method 'GET'.\"}")
        asset = CrowdPay::Asset.find(account_id, id)
        expect(asset.errors[:api]).to eq(["The requested resource does not support http method 'GET'."])
      end
    end
  end

end
