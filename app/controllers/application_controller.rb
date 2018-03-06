class ApplicationController < Sinatra::Base
  set :views, 'app/views'
  enable :sessions
  set :session_secret, "password_security"
  set :public_folder, 'public'
  use Rack::Flash
  register Sinatra::Reloader
  register Sinatra::ActiveRecordExtension

  get '/' do
    @title = 'Index'
    haml :index
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end