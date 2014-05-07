require 'spec_helper'

describe Vcloud::Walker::Resource::VApp do

  context 'populate summary vapp model' do
    before(:each) do
      fog_vapp = Fog::ServiceLayerStub.vapp_body
      @metadata = {:name => 'web-app-1', :shutdown => true}
      Vcloud::Core::Vapp.should_receive(:get_metadata).with("vapp-aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee").and_return(@metadata)
      Vcloud::Walker::Resource::Vms.should_receive(:new).with(fog_vapp[:Children][:Vm])

      @vapp_summary = Vcloud::Walker::Resource::VApp.new(fog_vapp)
    end

    it 'should report id from the href' do
      expect(@vapp_summary.id).to eq('vapp-aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee')
    end

    it "should report metadata" do
      expect(@vapp_summary.metadata.count).to eq(2)
      expect(@vapp_summary.metadata).to eq(@metadata)
    end
  end
end
