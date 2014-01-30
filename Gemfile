source 'https://rubygems.org'

gemspec

if ENV['VCLOUD_WALKER_DEV_FOG_MASTER']
  gem 'fog', :git => 'git@github.com:fog/fog.git', :branch => 'master'
  gem 'vcloud-core', :git => 'git@github.com:alphagov/vcloud-core.git', :branch => 'master'
elsif ENV['VCLOUD_WALKER_DEV_FOG_LOCAL']
  gem 'fog', :path => '../fog'
  gem 'vcloud-core', :path => '../vcloud-core'
end

