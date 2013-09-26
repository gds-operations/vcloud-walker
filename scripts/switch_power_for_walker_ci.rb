require File.expand_path("../../lib/walk/walk.rb", __FILE__)

usage = 'bundle exec ruby script/switch_power_for_walker_ci.rb (on/off)'
unless ARGV.count == 1 && %w(on off).include?(ARGV[0])
  p usage;
  raise 'Invalid Arguments'
end

power_mode = ARGV[0]

org = Walk::Organization.get_by_id('4-3-51-7942a4')
vdc = org.vdcs.get_by_name('GDS Networking API Testing (IL0-DEVTEST-BASIC)')
vapp = vdc.vapps.get_by_name 'vcloud-walker-contract-testing-vapp'
vapp.send("power_#{power_mode}")