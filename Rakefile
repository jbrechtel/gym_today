require 'bundler'
require 'bundler/setup'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

task :start do
  require_relative './lib/gym_today'
  GymTodayServer.run!
end

