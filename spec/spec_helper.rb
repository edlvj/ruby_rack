require './app/racker.rb'
require 'edlvj_codebreaker'
require 'rack'
require 'rack/test'
require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
   config.include Rack::Test::Methods
end

app_content = File.read('./config.ru')
Capybara.app = eval "Rack::Builder.new {( #{app_content}\n )}"

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome
