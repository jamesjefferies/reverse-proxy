require 'rack/reverse_proxy'
require 'erb'

# use Rack::RewindableInput::Middleware

routes = [
  { path: '/egg-timer', url: 'https://egg-timer-test-5531a35f62f6.herokuapp.com/' },
  { path: '/standing-orders', url: 'https://standingorders.shedcode.co.uk/standing-orders' }
]

use Rack::Timeout, service_timeout: 15  if ENV["ENV"] == "production"
use ActionDispatch::SSL                 if ENV["ENV"] == "production"

use Rack::ReverseProxy do
  # Set :preserve_host to true globally (default is true already)
  reverse_proxy_options preserve_host: true

  # Forward the path /test* to http://example.com/test*
  reverse_proxy '/egg-timer', 'https://egg-timer-test-5531a35f62f6.herokuapp.com'
  reverse_proxy '/standing-orders', 'https://standingorders.shedcode.co.uk/standing-orders'
  reverse_proxy '/procedure-browser', 'https://procedure-browser-159b715822a4.herokuapp.com'
  # Forward the path /foo/* to http://example.com/bar/*
  # reverse_proxy /^\/foo(\/.*)$/, 'http://example.com/bar$1', username: 'name', password: 'basic_auth_secret'
end

app = proc do |env|
  # Read the HTML file
  html_content = File.read('public/index.html')

  [
    200,
    {'Content-Type' => 'text/html'},
    [html_content]
  ]
end

run app