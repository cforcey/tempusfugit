# spec/spec_helper.rb
RSpec.configure do |config|
  config.include AttributeNormalizer::RSpecMatcher, :type => :model
end