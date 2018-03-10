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
    @shows = Show.select('shows.name, shows.id, count(users.id) as users_count').joins(:users).group('shows.id').order('users_count desc').limit(10)
    haml :index
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def watched?(show)
      UserShow.find_by(show_id: show.id, user_id: current_user.id).watched
    end

    def current_user_show(show)
      UserShow.find_by(user_id: current_user.id, show_id: show.id)
    end
  end
end