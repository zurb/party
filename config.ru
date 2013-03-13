require 'rubygems'
require 'bundler'
Bundler.require
require './party'

set :raise_errors, true

run Rack::URLMap.new({
  "/15" => Public,
  "/15/admin" => Admin
})