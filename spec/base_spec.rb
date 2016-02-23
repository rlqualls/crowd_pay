require 'spec_helper'
require 'socket'

class DummyClass
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  include CrowdPay::Base
  attr_accessor :x, :y
  register_association :node_ones, class_name: "NodeOneClass"
  register_association :node_twos, class_name: "NodeTwoClass"
end

class NodeOneClass
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  include CrowdPay::Base
  attr_accessor :a, :b
end

class NodeTwoClass
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  include CrowdPay::Base
  attr_accessor :j, :k
end

RSpec.describe CrowdPay::Base, :type => :lib do

  context "Test if the Class included CrowdPay methods properly" do
    it "should include crowd pay module" do
      expect(DummyClass.connection).not_to be(nil)

      dummy = DummyClass.new
      expect(dummy.respond_to?(:connection)).to be(true)
      expect(dummy.class.respond_to?(:connection)).to be(true)

      expect(dummy.class.respond_to?(:domain)).to be(true)
      expect(dummy.class.respond_to?(:api_key)).to be(true)
      expect(dummy.class.respond_to?(:portal_key)).to be(true)

      expect(dummy.class.respond_to?(:get)).to be(true)
      expect(dummy.class.respond_to?(:post)).to be(true)
      expect(dummy.class.respond_to?(:put)).to be(true)
      expect(dummy.class.respond_to?(:delete)).to be(true)

      expect(dummy.class.connection).not_to be(nil)
    end

    it "should include the initialize method which accepts multiple attributes" do
      dummy = DummyClass.new(x: 1, y: "abcde")
      expect(dummy.x).to eq(1)
      expect(dummy.y).to eq("abcde")
    end

    it "should include the initialize method which accepts associated attributes" do
      dummy = DummyClass.new(x: 1, y: "abcde")
      expect(dummy.x).to eq(1)
      expect(dummy.y).to eq("abcde")
    end
  end

  context "Instance Methods" do
    it "initialize" do
      dummy = DummyClass.new
      expect(dummy.x).to be(nil)
      expect(dummy.y).to be(nil)
      dummy.send :initialize, {x: 1, y: 2, node_ones: [{a: "Banana", b: "Mango"}], node_twos: [{j: "Grapes", k: "Apple"}]}
      expect(dummy.x).to be(1)
      expect(dummy.y).to be(2)
      expect(dummy.node_ones.first).to be_a(NodeOneClass)
      expect(dummy.node_ones.first.a).to eq("Banana")
      expect(dummy.node_ones.first.b).to eq("Mango")
      expect(dummy.node_twos.first).to be_a(NodeTwoClass)
      expect(dummy.node_twos.first.j).to eq("Grapes")
      expect(dummy.node_twos.first.k).to eq("Apple")
    end

    it "assign_attributes" do
      dummy = DummyClass.new
      response = double("response", :status => 201, body: "{\"x\":1,\"y\":2}")
      hash = JSON.parse(response.body)
      dummy.assign_attributes(hash)
      expect(dummy.x).to be(1)
      expect(dummy.y).to be(2)
    end

    # it '#attributes' do
    #   dummy = DummyClass.new x: 1, y: 'abcde'
    #   expect(dummy.attributes).to eq(x: 1, y: 'abcde')
    # end

    context "populate_errors" do
      it "should display the errors[:api] if status is 405" do
        dummy = DummyClass.new
        body = {'Message' => "The requested resource does not support http method 'GET'."}
        dummy.populate_errors(body)
        expect(dummy.errors[:api]).to eq(["The requested resource does not support http method 'GET'."])
      end

      it "should display the errors[:api] if status is 400" do
        dummy = DummyClass.new
        body = {'Message'=>'The request is invalid.', 'ModelState'=>{'investor'=>['An error has occurred.', 'An error has occurred.', 'An error has occurred.'], 'investor.tax_id_number'=>['The tax_id_number field is required.'], 'investor.created_by_ip_address'=>['The created_by_ip_address field is required.']}}
        dummy.populate_errors(body)
        expect(dummy.errors[:api]).to eq(["The request is invalid."])
        expect(dummy.errors[:tax_id_number]).to eq(["The tax_id_number field is required."])
        expect(dummy.errors[:created_by_ip_address]).to eq(["The created_by_ip_address field is required."])
      end

      it "should display the errors[:api] if status is 409" do
        dummy = DummyClass.new
        body = {'Code'=>'20000', 'Message'=>'Investor with same tax id already exists.', 'Model'=>'Investor', 'ModelObject'=>{'id'=>78629, 'investor_key'=>'a433d29f-837a-4f84-a7bc-b7e97c677c07', 'tax_id_number'=>'*****2025', 'first_name'=>'Investor First', 'middle_name'=>'Investor Middle', 'last_name'=>'Investor Last', 'name'=>'Investor First Investor Middle Investor Last', 'birth_date'=>'1985-04-07T00:00:00', 'mailing_address_1'=>'123 Ave A', 'mailing_address_2'=>nil, 'mailing_city'=>'Somewhere', 'mailing_state'=>'TX', 'mailing_zip'=>'79109', 'mailing_country'=>nil, 'is_mailing_address_foreign'=>false, 'legal_address_1'=>'123 Ave A', 'legal_address_2'=>nil, 'legal_city'=>'Somewhere', 'legal_state'=>'TX', 'legal_zip'=>'79109', 'legal_country'=>nil, 'is_legal_address_foreign'=>false, 'primary_phone'=>'1112223333', 'secondary_phone'=>'2223334444', 'is_person'=>true, 'email'=>'cgrimes@qwinixtech.com', 'is_cip_satisfied'=>false, 'portal_investor_number'=>'yourinvestornumber', 'created_by_ip_address'=>'192.168.2.61', 'Accounts'=>[]}}
        dummy.populate_errors(body)
        expect(dummy.errors[:api]).to eq(['Investor with same tax id already exists.'])
      end
    end
  end

  context "Class Methods" do
    it "create_connection" do
      dummy = DummyClass.new
      expect(dummy.connection).to be_a(Faraday::Connection)
      expect(dummy.connection.headers["X-ApiKey"]).not_to be_nil
      expect(dummy.connection.headers["X-PortalKey"]).not_to be_nil
    end

    it "parse" do
      response = double("response", :status => 201, body: "{\"x\":1,\"y\":2}")
      dummy = DummyClass.parse(response)
      expect(dummy.x).to be(1)
      expect(dummy.y).to be(2)
    end

    it "get" do
      url = "https://test.crowdpay.com/Crowdfunding/api/DummyClass/investor_key"
      stub_request(:get, url).to_return(:status => 200, :body => "{\"x\":1,\"y\":2}")
      path = "Crowdfunding/api/DummyClass/investor_key"
      response = DummyClass.get(path)
      expect(response.status).to eq(200)
      expect(response.body).to eq("{\"x\":1,\"y\":2}")
    end

    it "post" do
      url = "https://test.crowdpay.com/Crowdfunding/api/DummyClass"
      stub_request(:post, url).to_return(:status => 201, :body => "{\"x\":1,\"y\":2}")
      path = "Crowdfunding/api/DummyClass"
      response = DummyClass.post(path, {"x" => 1, "y" => 2})
      expect(response.status).to eq(201)
      expect(response.body).to eq("{\"x\":1,\"y\":2}")
    end

    it "put" do
      url = "https://test.crowdpay.com/Crowdfunding/api/DummyClass/1"
      stub_request(:put, url).to_return(:status => 201, :body => "{\"x\":1,\"y\":2}")
      path = "Crowdfunding/api/DummyClass/1"
      response = DummyClass.put(path, {"x" => 1, "y" => 2})
      expect(response.status).to eq(201)
      expect(response.body).to eq("{\"x\":1,\"y\":2}")
    end

    it "delete" do
      url = "https://test.crowdpay.com/Crowdfunding/api/DummyClass/1"
      stub_request(:delete, url).to_return(:status => 201, :body => "{\"x\":1,\"y\":2}")
      path = "Crowdfunding/api/DummyClass/1"
      response = DummyClass.delete(path)
      expect(response.status).to eq(201)
      expect(response.body).to eq("{\"x\":1,\"y\":2}")
    end

    it "register_association" do
      expect(DummyClass::associations).to eq({node_ones: {class_name: "NodeOneClass"}, node_twos: {class_name: "NodeTwoClass"}})
    end

  end
end
