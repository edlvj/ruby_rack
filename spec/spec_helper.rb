require './app/racker.rb'
require 'edlvj_codebreaker'
require 'rack'
require 'rack/test'


RSpec.configure do |config|
   config.include Rack::Test::Methods
end