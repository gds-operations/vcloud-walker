require 'spec_helper'

describe Vcloud::Walker::Resource::VApp do

  context 'populate summary vapp model' do
    before(:all) do
      fog_vapp = Fog::ServiceLayerStub.vapp_body
      Vcloud::Walker::Resource::Vms.should_receive(:new).with(fog_vapp[:Children][:Vm])

      @vm_summary = Vcloud::Walker::Resource::VApp.new(fog_vapp)
    end

    it 'should report id from the href' do
      @vm_summary.id.should == 'vapp-aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee'
    end
  end
end
