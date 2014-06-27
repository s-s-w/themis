ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/rails'
require 'minitest/rails/capybara'

require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
#Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new

#class ActionDispatch::IntegrationTest
#	include Capybara::DSL
#	include Capybara::Assertions
#end

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  
  def self.prepare
    #FactoryGirl.lint
  end
  prepare
end
