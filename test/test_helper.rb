ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def assert_array_match(first, second)
    assert_equal first.to_a.sort, second.to_a.sort
  end

  # Add more helper methods to be used by all tests here...
end
