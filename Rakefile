require "bundler/gem_tasks"
require 'rake/testtask'
require 'rspec/core/rake_task'
require 'gem_publisher'

RSpec::Core::RakeTask.new(:spec) do |task|
task.pattern = FileList['spec/**/*_spec.rb'] - FileList['spec/integration/*_spec.rb']
end

RSpec::Core::RakeTask.new(:integration_test) do |task|
task.pattern = FileList['spec/integration/*_spec.rb']
end

require "gem_publisher"

task :default => :spec

desc "Publish gem to RubyGems.org"
task :publish_gem do |t|
  gem = GemPublisher.publish_if_updated("vcloud_walker.gemspec", :rubygems)
  puts "Published #{gem}" if gem
end
