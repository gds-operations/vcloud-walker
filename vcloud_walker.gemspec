# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vcloud/walker/version"

Gem::Specification.new do |s|
  s.name        = "vcloud-walker"
  s.version     = Vcloud::Walker::VERSION
  s.authors     = ['Government Digital Service']
  s.homepage    = "https://github.com/alphagov/vcloud-walker"
  s.summary     = %q{Command line tool to describe vCloud entities}
  s.description = %q{Vcloud-walker is a command line tool , to describe different vcloud entities.
                    This tool is a thin layer around fog api, which exposes summarized vcloud entities
                    in the form of JSON}

  s.rubyforge_project = "vcloud-walker"

  s.files         = `git ls-files`.split("\n")
  s.executables   = s.files.grep(%r{^bin/}) {|f| File.basename(f)}
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.license = 'MIT'

  s.add_development_dependency "rake"
  s.add_development_dependency 'rspec', '~> 2.14.1'
  s.add_development_dependency 'rspec-mocks', '~> 2.14.3'
  s.add_development_dependency "json_spec", "~> 1.1.1"
  s.add_runtime_dependency 'json', '~> 1.8.0'
  s.add_runtime_dependency 'methadone'
  s.add_runtime_dependency 'thor', '~> 0.18.1'
  s.add_runtime_dependency 'fog', '>= 1.19.0'
  s.add_development_dependency 'simplecov', '~> 0.8.2'
  s.add_development_dependency "jeweler", "~> 2.0.1"
end
