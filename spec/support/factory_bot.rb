# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  FactoryBot.find_definitions if FactoryBot.factories.count.zero?
end
