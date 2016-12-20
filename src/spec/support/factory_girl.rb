# frozen_string_literal: true
# Use FactoryGirl keywords directly in rspec

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
