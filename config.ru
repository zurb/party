require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'json'
require 'party'
 
set :raise_errors, true

run Rack::URLMap.new({
  "/" => Public,
  "/admin" => Admin
})
 