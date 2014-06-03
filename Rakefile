require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rspec/core/rake_task'
require 'vcloud/walker/version'

RSpec::Core::RakeTask.new(:spec) do |task|
  ENV['COVERAGE'] = 'true'
  task.pattern = FileList['spec/**/*_spec.rb'] - FileList['spec/integration/*_spec.rb']
end

RSpec::Core::RakeTask.new(:integration) do |task|
  task.pattern = FileList['spec/integration/*_spec.rb']
end

task :default => [ :rubocop, :spec ]

require "gem_publisher"
task :publish_gem do
  gem = GemPublisher.publish_if_updated("vcloud-walker.gemspec", :rubygems)
  puts "Published #{gem}" if gem
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.options = ['--lint']
end
