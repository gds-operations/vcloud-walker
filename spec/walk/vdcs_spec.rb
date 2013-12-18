require 'spec_helper'
require 'fog'

describe Vcloud::Walker::Resource::Vdcs do
  let(:api_session) { double(:fog_session) }

  context 'vdcs' do

    it "should summarize vdcs" do
      Fog::Compute::VcloudDirector.should_receive(:new).with(any_args()).and_return(api_session)
      mock_fog_vdcs = StubCollectionBuilders.vdcs(StubVdc.new.vapps([mock_vapp]).build)
      api_session.should_receive(:get_vapp).with(1).and_return(Fog::ServiceLayerStub.mock_vapp)
      Vcloud::Core::Vm.stub(:get_metadata).with("vm-d19d84a5-c950-4497-a638-23eccc4226a5").and_return({})

      vdcs_summary = Vcloud::Walker::Resource::Vdcs.new(mock_fog_vdcs).to_summary

      vdc_summary = vdcs_summary.first
      vdc_summary[:vapps].count.should == 1
      vdc_summary[:vapps].first[:vms].count == 1
    end

    private

    def mock_vapp
      double(:vapp, :id => 1)
    end

  end
end
