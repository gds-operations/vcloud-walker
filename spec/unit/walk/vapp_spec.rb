require 'unit/spec_helper'

describe Vcloud::Walker::Resource::VApp do

  context 'populate summary vapp model' do
    before(:all) do
      fog_vapp = Fog::ServiceLayerStub.vapp_body

      @vm_summary = Vcloud::Walker::Resource::VApp.new(fog_vapp)
    end

    it 'should report id from the href' do
      @vm_summary.id.should == 'vapp-aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee'
    end
  end
end
