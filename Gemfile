source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'webmock'
end

group :test do
  gem 'rspec-sidekiq'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'kaminari'
gem 'pg'
gem 'fabrication'
gem 'ffaker'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'active_model_serializers'
gem 'money-rails'
gem 'sidekiq'
gem 'rspec_api_documentation'
gem 'apitome'
gem 'yard'
gem 'rubocop'
gem 'simplecov'

group :production do
  gem 'rails_12factor' #this is a gem Heroku also asks you to have as part of your Gemfile
  gem 'bonsai-elasticsearch-rails'
end

