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
# gem 'turbolinks'

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

# authentication gem, temporarily from git until r4 release
gem 'devise', :git => 'git://github.com/plataformatec/devise.git', :branch => 'rails4'

# temporary adjustment for devise reliance on attribute accessible
gem 'protected_attributes'

# bootstrap gem for styling
gem 'bootstrap-sass', '~> 2.3.1.0'

# fontawesome for font based icons compatible with bootstrap
gem 'font-awesome-sass-rails'

# simple_form to make form generation easier and better, temporarily from git until r4 release
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'

# abilities and permissions (no need for more complex roles yet)
gem 'cancan'

# role based abilities with specs
gem 'canard'

# simple active link for the top navigation
gem 'active_link_to'

# sanitizes input for leading spaces, length, etc.
gem 'attribute_normalizer'

# natural language time parser
gem 'chronic'

####################### gems needed for just development and testing
group :development do
  # a convenient generator for locale files from the database and repos
  gem 'i18n_generators', '~> 1.2.1'
end

group :development, :test do
  # rspec testing
  gem 'rspec-rails'
  # factory girl can be handy in development too for generators
  gem 'factory_girl_rails'
  # a nice random data generator useful for db:seeds as well
  gem 'random_data'
end  

####################### gem needed just for testing
group :test do
  # browser simulator over RackTest
  gem 'capybara'
  # alternative to selenium and faster
  gem 'capybara-webkit'
  # database cleaner for when transactions are not available
  gem 'database_cleaner'
  # nice set of concise validation tests
  gem 'accept_values_for'
end