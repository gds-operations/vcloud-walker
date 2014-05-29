require 'spec_helper'
require 'rspec/mocks'
require 'fog'

describe Vcloud::Walker::Resource::Networks do

  context "Summary" do
    before(:each) do
      set_login_credential
    end

    it "should walk all networks within given org" do
      mock_fog_network = mock_fog_network_object
      networks = Vcloud::Walker::Resource::Networks.new([mock_fog_network, mock_fog_network])
      expect(networks.count).to eq(2)
    end

    it "should be happy with one network" do
      mock_fog_network = mock_fog_network_object
      networks = Vcloud::Walker::Resource::Networks.new([mock_fog_network])
      expect(networks.count).to eq(1)
    end

    it "should handle having no networks" do
      networks = Vcloud::Walker::Resource::Networks.new([])
      expect(networks.count).to eq(0)
    end

    it "should map parameters of a network to the local entity" do
      mock_fog_network = mock_fog_network_object
      expect(mock_fog_network).to receive(:dns1).and_return('sausage')

      networks = Vcloud::Walker::Resource::Networks.new([mock_fog_network])

      expect(networks.count).to eq(1)
      expect(networks.first.id).to eq(:network_id_1)
      expect(networks.first.name).to eq(:name)
      expect(networks.first.dns_suffix).to eq(:dns_suffix)
      expect(networks.first.dns1).to eq('sausage')
    end

  end

  private
  def mock_fog_network_object
    double(:fog_network,
           :id => :network_id_1,
           :name => :name,
           :description => :default,
           :is_inherited => false,
           :gateway => false,
           :netmask => :default,
           :dns_suffix => :dns_suffix,
           :dns2 => :default,
           :dns1 => :default,
           :ip_ranges => :default)
  end


end
