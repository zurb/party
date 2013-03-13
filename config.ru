require 'rubygems'
require 'bundler'
Bundler.require
require './party'

set :raise_errors, true

run Rack::URLMap.new({
  "/" => Public,
  "/admin" => Admin
})