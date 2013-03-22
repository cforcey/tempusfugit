source 'https://rubygems.org'

# Bundler supports ruby version declarations
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.beta1'

gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0.beta1'
  gem 'coffee-rails', '~> 4.0.0.beta1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', group: :development

# To use debugger
# gem 'debugger'

# Customized gems installed for this project
# Normally these would be limited to ~> minor
# versions but this is so bleeding edge I plan
# to be updating often and would lock them
# down once rails 4 stabilizes a bit

####################### gems needed in all environments

# authentication gem
gem 'devise', :git => 'git://github.com/plataformatec/devise.git', :branch => 'rails4'

# temporary adjustment for devise reliance on attribute accessible
gem 'protected_attributes'

# bootstrap gem for styling
gem 'bootstrap-sass', '~> 2.3.1.0'

####################### gems needed for just development and testing
group :development, :test do
  # rspec testing
  gem 'rspec-rails'
end  

####################### gem needed just for testing
group :test do
  # browser simulator over RackTest
  gem 'capybara'
  # alternative to selenium and faster
  gem 'capybara-webkit'
end