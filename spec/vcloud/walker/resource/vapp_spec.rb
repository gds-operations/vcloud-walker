require 'spec_helper'

describe Vcloud::Walker::Resource::VApp do

  context 'populate summary vapp model' do
    before(:each) do
      fog_vapp = Fog::ServiceLayerStub.vapp_body
      @metadata = {:name => 'web-app-1', :shutdown => true}
      expect(Vcloud::Core::Vapp).to receive(:get_metadata).with("vapp-aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee").and_return(@metadata)
      expect(Vcloud::Walker::Resource::Vms).to receive(:new).with(fog_vapp[:Children][:Vm])

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

  context 'malformed vApp with no networks attached' do
    before(:each) {
      allow(Vcloud::Core::Vapp).to receive(:get_metadata)
      allow(Vcloud::Walker::Resource::Vms).to receive(:new)
    }

    describe "network_config" do
      shared_examples "network_config" do
        it 'should report an empty network_config without any errors' do
          vapp = Vcloud::Walker::Resource::VApp.new(fog_vapp)
          expect(vapp.network_config).to eq([])
        end
      end

      context 'missing vapp[:NetworkConfigSection]' do
        let(:fog_vapp) {
          v = Fog::ServiceLayerStub.vapp_body
          v.delete(:NetworkConfigSection)
          v
        }

        include_examples "network_config"
      end

      context 'missing vapp[:NetworkConfigSection][:NetworkConfig]' do
        let(:fog_vapp) {
          v = Fog::ServiceLayerStub.vapp_body
          v[:NetworkConfigSection].delete(:NetworkConfig)
          v
        }

        include_examples "network_config"
      end
    end

    describe "network_section" do
      shared_examples "network_section" do
        it 'should report an empty network_section without any errors' do
          vapp = Vcloud::Walker::Resource::VApp.new(fog_vapp)
          expect(vapp.network_section).to eq({})
        end
      end

      context 'missing vapp[:"ovf:NetworkSection"]' do
        let(:fog_vapp) {
          v = Fog::ServiceLayerStub.vapp_body
          v.delete(:"ovf:NetworkSection")
          v
        }

        include_examples "network_section"
      end

      context 'missing vapp[:"ovf:NetworkSection"][:"ovf:Network"]' do
        let(:fog_vapp) {
          v = Fog::ServiceLayerStub.vapp_body
          v[:"ovf:NetworkSection"].delete(:"ovf:Network")
          v
        }

        include_examples "network_section"
      end
    end
  end
end
