# allows for short syntax create(:user) style calls to factories
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end