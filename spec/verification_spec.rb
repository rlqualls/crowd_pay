require 'spec_helper'

describe 'CrowdPay::Verification' do
  context 'validate factories' do
    let(:verification) { FactoryGirl.build :verification }

    it 'should validate the investor factories' do
      expect(verification.valid?).to be(true)
    end
  end

  describe '.verify' do
    let(:url) { 'https://test.crowdpay.com/identification/api/v1/ops/verify-identity' }

    let(:verification_attributes) { FactoryGirl.attributes_for :verification }

    context 'pass' do
      it 'shows that a pass has occured' do
        stub_request(:post, url).to_return status: 200,
          body: '{"id":"1254778630","Key":"id.success","Message":"Pass"}'

        verify = CrowdPay::Verification.verify verification_attributes, false

        expect(verify.pass?).to eq(true)
        expect(verify.fail?).to eq(false)
        expect(verify.soft_fail?).to eq(false)
      end
    end

    context 'hard fail' do
      it 'shows that a fail has occured' do
        stub_request(:post, url).to_return status: 200,
          body: '{"id":"1254778630","Key":"id.failure","Message":"Fail"}'

        verify = CrowdPay::Verification.verify verification_attributes, false

        expect(verify.fail?).to eq(true)
        expect(verify.pass?).to eq(false)
        expect(verify.soft_fail?).to eq(false)
      end

      it 'handles other failure messages' do
        stub_request(:post, url).to_return status: 200,
          body: '{"Key":"id.error","Message":"No first name submitted"}'

        verify = CrowdPay::Verification.verify verification_attributes, false

        expect(verify.pass?).to eq(false)
        expect(verify.fail?).to eq(true)
        expect(verify.soft_fail?).to eq(false)
      end
    end

    context 'soft fail' do
      it 'shows that a soft fail has occured' do
        stub_request(:post, url).to_return status: 200,
          body: fixture(:verification_soft_fail)

        verify = CrowdPay::Verification.verify verification_attributes, false

        expect(verify.soft_fail?).to eq(true)
        expect(verify.fail?).to eq(true)
        expect(verify.pass?).to eq(false)
      end
    end
  end

  describe '.verify_answers' do
    let(:url) { 'https://test.crowdpay.com/identification/api/v1/ops/verify-answers' }

    it 'shows that a pass has occured when pass' do
      stub_request(:post, url).to_return status: 200,
        body: '{"Id":"1265185524","Key":"result.questions.0.incorrect","Message":"All answers correct","Summary":"pass"}'

      verify = CrowdPay::Verification.verify_answers answers: []

      expect(verify.pass?).to eq(true)
      expect(verify.fail?).to eq(false)
    end

    it 'shows that a fail has occured when fail' do
      stub_request(:post, url).to_return status: 200,
        body: '{"Id":"1265411516","Key":"result.questions.3.incorrect","Message":"Three Incorrect Answers","Summary":"fail"}'

      verify = CrowdPay::Verification.verify_answers answers: []

      expect(verify.fail?).to eq(true)
      expect(verify.pass?).to eq(false)
    end
  end
end
