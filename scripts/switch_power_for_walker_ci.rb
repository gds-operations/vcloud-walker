require 'vcloud/walker'

usage = 'bundle exec ruby script/switch_power_for_walker_ci.rb (on/off)'
unless ARGV.count == 1 && %w(on off).include?(ARGV[0])
  p usage
  raise 'Invalid Arguments'
end

power_mode = ARGV[0]

org = Vcloud::Walker::FogInterface.get_org
vdc = org.vdcs.get_by_name(ENV['VDC_NAME'])
vapp = vdc.vapps.get_by_name ENV['WALKER_CI_VAPP']
response = vapp.send("power_#{power_mode}")

response ? (puts "Turned #{power_mode} walker ci.") : (raise "unable to turn #{power_mode} walker ci")
