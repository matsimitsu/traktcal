require 'sinatra'
require 'config/api_keys'
require 'digest/sha1'

require 'lib/trakt'

class Application < Sinatra::Base
  Trakt::API_KEY = TRAKT_API_KEY
  set :root, File.dirname(__FILE__)
  set :views, settings.root + '/templates'
  set :public_folder, settings.root + '/public'

  configure do
    set :environment, :develop
    set :dump_errors, true
    set :haml, { :ugly=>true }
    set :clean_trace, true
  end

  get '/' do
    haml :index
  end

  post '/' do
    if params[:username] && params[:password]
      @username = params[:username]
      @password = Digest::SHA1.hexdigest params[:password]
    end
    haml :index
  end

  get '/calendar.ics' do
    content_type 'text/calendar', :charset => 'utf-8'
    @results = Trakt::User::Calendar.new(params[:username], params[:password]).results
    erb :calendar
  end

  get '/application.css' do
    content_type 'text/css', :charset => 'utf-8'
    sass :application, :style => :expanded
  end

end