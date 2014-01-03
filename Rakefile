require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rspec/core/rake_task'
require 'vcloud/walker/version'

RSpec::Core::RakeTask.new(:spec) do |task|
task.pattern = FileList['spec/**/*_spec.rb'] - FileList['spec/integration/*_spec.rb']
end

RSpec::Core::RakeTask.new(:integration_test) do |task|
task.pattern = FileList['spec/integration/*_spec.rb']
end

task :default => :spec

require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name = 'vcloud_walker'
  gem.version = Vcloud::Walker::VERSION
end
Jeweler::RubygemsDotOrgTasks.new
