DataMapper::setup(:default, "sqlite3://#{File.expand_path("..",Dir.pwd)}/shared/party.db")

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
  get '/' do
    erb :index
  end

  post '/' do
    content_type :json
    @rsvp = Rsvp.first_or_create({ :email => params[:email] }, {
      :attending => params[:attending],
      :name      => params[:name],
      :email     => params[:email].empty? ? 'not provided' : params[:email],
      :guests    => params[:guests].empty? ? 0 : params[:guests],
      :created_at => Time.now,
      :updated_at => Time.now 
    })
    @rsvp.to_json
  end
end

class Admin < Sinatra::Base
  use Rack::Auth::Basic, "Admin Area" do |username, password|
    username == 'zurb' && password == 'party'
  end

  get '/' do 
    redirect '/admin/guests'
  end

  get '/guests' do
    @rsvps = Rsvp.all
    @title = 'All RSVPs'
    erb :guests
  end
end
