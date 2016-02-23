require 'spec_helper'

describe CrowdPay::Escrow do
  let(:escrow) { FactoryGirl.build(:escrow) }

  context "validate factories" do
    it "should validate the asset factories" do
      escrow = FactoryGirl.build(:escrow)
      expect(escrow.valid?).to be(true)
    end
  end

  context ".find" do
    it "find all escrows" do
      stub_request(:get, 'https://test.crowdpay.com/Crowdfunding/api/Escrows')
      .to_return status: 200, body: fixture(:escrows)
      escrow = CrowdPay::Escrow.find.first
      expect(escrow).to be_an(CrowdPay::Escrow)
    end
  end

  context ".find with id" do
    it "find all escrows" do
      escrow_id = "78627"
      stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/Escrows/#{escrow_id}")
      .to_return status: 200, body: fixture(:escrow)
      escrow = CrowdPay::Escrow.find(escrow_id)
      expect(escrow).to be_an(CrowdPay::Escrow)
    end
  end

  context ".find_with_transactions" do
    it "find escrows transactions" do
      escrow_id = "78627"
      stub_request(:get, "https://test.crowdpay.com/Crowdfunding/api/Escrows/#{escrow_id}/Transactions").to_return status: 200, body: fixture(:escrow_with_transactions)
      escrow = CrowdPay::Escrow.find_with_transactions(escrow_id)
      expect(escrow).to be_an(CrowdPay::Escrow)
    end
  end
end
