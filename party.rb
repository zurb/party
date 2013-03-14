require 'json'
require 'fileutils'

SHARED_PATH = File.expand_path("../../shared", __FILE__)
FileUtils.mkdir_p(SHARED_PATH) unless File.directory?(SHARED_PATH)
DataMapper::setup(:default, "sqlite3://#{SHARED_PATH}/party.db")

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
  configure :development do
    set :sub_uri, "/"
  end

  configure :production do
    set :sub_uri, "/15/"
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
  configure :development do
    set :sub_uri, "/"
  end

  configure :production do
    set :sub_uri, "/15/"
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
