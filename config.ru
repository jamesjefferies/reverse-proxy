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
  reverse_proxy '/egg-timer', 'https://parliament-egg-timer.herokuapp.com'
  reverse_proxy '/egg-timer-test', 'https://egg-timer-test-5531a35f62f6.herokuapp.com'
  reverse_proxy '/standing-orders', 'https://standingorders.shedcode.co.uk/standing-orders'
  reverse_proxy '/procedure-browser', 'https://procedure-browser-159b715822a4.herokuapp.com'
  reverse_proxy '/bill-papers', 'https://bill-papers.herokuapp.com/bill-papers'
  reverse_proxy '/committees', 'https://uk-parliament-committees.herokuapp.com/committees'
  reverse_proxy '/library-feeds', 'https://library-feeds-598afbedcb83.herokuapp.com/library-feeds'
  reverse_proxy '/mnis-prodder', 'https://mnis-prodder.herokuapp.com/mnis-prodder'
  reverse_proxy '/regnal-years', 'https://regnal-years-46ac7da1fe8b.herokuapp.com/regnal-years'
  reverse_proxy '/uk-general-elections', 'https://uk-general-elections.herokuapp.com/uk-general-elections'
  reverse_proxy '/uk-treaties', 'https://uk-treaties.herokuapp.com/uk-treaties'
  reverse_proxy '/written-answers', 'https://written-questions.herokuapp.com/written-answers'
  reverse_proxy '/psephology', 'https://electionresults.parliament.uk'
  reverse_proxy '/psephology-test', 'https://psephology-test-72dc15bebb5d.herokuapp.com/'










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