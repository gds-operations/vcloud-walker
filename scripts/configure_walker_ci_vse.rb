require 'thor'
require 'vcloud_network_configurator'

class ConfigureWalkerCiVse < Thor
  map "-L" => :list

  API_URL = 'https://api.vcd.portal.skyscapecloud.com/api'
  WALKER_ORG_ID = '4-3-51-7942a4'
  EDGE_GATEWAY_UUID = 'c1b44ae3-7858-4c54-8fcd-fdc913d8314e'

  desc 'configures the walker CI VSE', 'configures lb, nat and firewall rules'

  def configure username, password
    raise "API credentials not provided" unless username && password

    rules_dir = File.expand_path(File.join(File.dirname(__FILE__), 'data/vse'))
    common_args = ['-u', username,
                   '-p', password,
                   '-o', WALKER_ORG_ID,
                   '-U', EDGE_GATEWAY_UUID,
                   '-i', "#{rules_dir}/interfaces.yaml",
    ]

    %w{firewall nat lb}.each do |component|
      puts "Executing component: #{component}"
      args = common_args + ['-c', component,
                            '-r', "#{rules_dir}/#{component}.rb",
                            API_URL]
      puts VcloudNetworkConfigurator.new(args).execute
    end
  end

end

ConfigureWalkerCiVse.new.configure(ARGV[0], ARGV[1])



