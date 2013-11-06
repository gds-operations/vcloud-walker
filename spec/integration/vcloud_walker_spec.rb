require_relative '../spec_helper'
require 'fog'
require 'stringio'

JsonSpec.directory = File.expand_path('../data/walker_ci', __FILE__)


describe Walk::Vdcs do
  context 'walk an organization' do

    it 'should describe vdcs' do
      expected_summary = Data.Load('walker_ci', 'vdcs')

      vdc_summaries = VcloudWalk.new.vdcs
      vdc_summaries.count.should == 1

      vdc_summary = vdc_summaries.first

      [:vapps, :quotas, :name, :id, :description].each do |k|
        vdc_summary[k].to_json.should == expected_summary[k].to_json
      end

      vdc_summary[:compute_capacity].should_not be_nil
    end

    it "should describe networks" do
      expected = load_json('networks.json')

      network_summary = VcloudWalk.new.networks

      network_summary.to_json.should be_json_eql(expected)
    end

    it "should describe catalogs" do
      catalog_summary = VcloudWalk.new.catalogs

      expected_catalog_summary = load_json('catalogs.json')

      #comparing catalogs added by us, ignoring the skyscape public catalogs
      select_walker_ci_catalog(catalog_summary).to_json.should be_json_eql(expected_catalog_summary)
    end

    private
    def select_walker_ci_catalog(catalog_summary)
      catalog_summary.select { |catalog| catalog[:name] == 'walker-ci' }
    end
  end
end
