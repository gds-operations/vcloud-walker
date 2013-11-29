require "bundler/gem_tasks"
require 'rake/testtask'
require 'rspec/core/rake_task'

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
end
Jeweler::RubygemsDotOrgTasks.new
