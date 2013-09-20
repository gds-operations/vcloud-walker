require_relative '../spec_helper'
require 'rspec/mocks'
require 'fabrication'
require 'fog'

describe Walk::Networks do
  let(:org) { double(:fog_org, :id => '4-3-51-7942a4') }
  let(:organizations) { double(:get_by_name => org) }
  let(:session) { double(:fog_api_session, :organizations => organizations) }

  it "should walk all networks within given org" do

    Fog::Compute::VcloudDirector.should_receive(:new).and_return(session)
    mock_fog_network = mock_fog_network_object()
    org.should_receive(:networks).and_return(mock(:all => [mock_fog_network, mock_fog_network]))

    networks = Walk::Networks.new('4-3-51-7942a4')

    networks.count.should == 2
  end


  it "should handle having no networks" do

    Fog::Compute::VcloudDirector.should_receive(:new).and_return(session)
    org.should_receive(:networks).and_return(mock(:all => []))

    networks = Walk::Networks.new('4-3-51-7942a4')

    networks.count.should == 0
  end


  it "should map parameters of a network to the local entity" do
    Fog::Compute::VcloudDirector.should_receive(:new).and_return(session)

    mock_fog_network = mock_fog_network_object
    expect(mock_fog_network).to receive(:dns1).and_return('sausage')

    org.should_receive(:networks).and_return(mock(:all => [mock_fog_network]))

    networks = Walk::Networks.new('4-3-51-7942a4')

    networks.count.should == 1
    networks.first.id.should == :network_id_1
    networks.first.name.should == :name
    networks.first.dns_suffix == :dns_suffix
    networks.first.dns1 == 'sausage'

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
