require 'json'
require 'fileutils'
require 'yaml'

env = ENV["RACK_ENV"] || "development"
ZURB_CODE = YAML::load_file(File.expand_path("../config/zurb_code.yml",__FILE__))[env]
db_path = File.expand_path(ZURB_CODE["database"])
FileUtils.mkdir_p(File.expand_path("..",db_path)) unless File.directory?(File.expand_path("..",db_path))
DataMapper::setup(:default, "sqlite3://#{db_path}")

class Rsvp
  include DataMapper::Resource

  property :id, Serial
  property :attending, Boolean, :required => true, :default => 0
  property :name, Text, :required => true
  property :email, Text, :required => true
  property :guests, Integer, :default => 0
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

class Public < Sinatra::Base
  configure do
    set :sub_uri, ZURB_CODE["sub_uri"]
  end

  get '/' do
    erb :index
  end

  post '/' do
    content_type :json
    @rsvp = Rsvp.first_or_create({ :email => params[:email] }, {
      :attending => params[:attending],
      :name      => params[:name],
      :email     => params[:email],
      :guests    => params[:guests].empty? ? 0 : params[:guests],
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @rsvp.to_json
  end
end

class Admin < Sinatra::Base
  configure do
    set :sub_uri, ZURB_CODE["sub_uri"]
  end

  use Rack::Auth::Basic, "Admin Area" do |username, password|
    username == 'zurb' && password == 'party'
  end

  get '/' do
    redirect "#{settings.sub_uri}admin/guests"
  end

  get '/guests' do
    @rsvps = Rsvp.all
    @title = 'All RSVPs'
    erb :guests
  end
end
