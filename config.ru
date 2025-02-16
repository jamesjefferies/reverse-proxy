require "rack_reverse_proxy"
require 'rack/reverse_proxy'

# use Rack::RewindableInput::Middleware

use Rack::ReverseProxy do
  # Set :preserve_host to true globally (default is true already)
  reverse_proxy_options preserve_host: true

  # Forward the path /test* to http://example.com/test*
  reverse_proxy '/egg-timer', 'https://egg-timer-test-5531a35f62f6.herokuapp.com/'
  reverse_proxy '/standing-orders', 'https://standingorders.shedcode.co.uk/standing-orders'

  # Forward the path /foo/* to http://example.com/bar/*
  # reverse_proxy /^\/foo(\/.*)$/, 'http://example.com/bar$1', username: 'name', password: 'basic_auth_secret'
end

app = proc do |env|
  [ 200, {'Content-Type' => 'text/plain'}, ["b"] ]
end

run app