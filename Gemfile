source "https://rubygems.org"

ruby file: '.tool-versions'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Rack stuff
gem "rack"
gem "rack-timeout"
gem "rack-reverse-proxy", github: "samedi/rack-reverse-proxy", branch: "main" #, branch: "feat/rack_2_and_3_compat"

gem "ostruct"

# Required for SSL forcing middleware
gem "actionpack"

# Rack startup
gem "rackup"
gem "puma"

# HTTP requests
gem "httpx"

# Environmental stuff
gem "dotenv"
gem "amazing_print"
gem "semantic_logger"

group :development do
  gem "rerun"
  gem "rb-fsevent"
  gem "overcommit"
end

group :test do
  gem "rack-test"
  gem "rspec"
  gem "rspec_junit_formatter"
  gem "climate_control"
  gem "webmock"
  gem "capybara"
  gem "cuprite"
end
