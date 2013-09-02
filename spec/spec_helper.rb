require 'rspec'
require 'rack/test'
require 'factory_girl'
require 'pry'
require './lib/gym_today'

Dir['./spec/factories/*.rb'].each do |f|
  require f
end
