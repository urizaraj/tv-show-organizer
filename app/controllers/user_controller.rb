class UserController < ApplicationController
  get '/signup' do
    redirect to '/' if logged_in?
    haml :'users/create_user'
  end

  post '/signup' do
    redirect to '/' if logged_in?

    user = User.new(params[:user])
    redirect back unless valid_info?(user)
    
    user.save
    redirect to '/login'
  end

  get '/login' do
    redirect to '/' if logged_in?
    haml :'users/login'
  end

  post '/login' do
    redirect to '/' if logged_in?
    user = User.find_by(username: params[:username])

    redirect to('/login') unless valid_user?(user, params)

    session[:user_id] = user.id
    flash[:message] = "Welcome, #{user.username}!"
    redirect to '/'
  end

  get '/logout' do
    session.clear
    redirect to('/login')
  end

  get '/manage' do
    redirect to '/login' unless logged_in?
    @user = current_user
    @shows = Show.all.order(:name)
    haml :'users/manage_shows'
  end

  post '/manage' do
    redirect to '/login' unless logged_in?
    user = current_user
    user.update(params[:user])
    redirect to "/users/#{user.slug}"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    redirect to '/users' unless @user
    # @shows = @user.shows.order(:name)
    @shows = @user.user_shows.where(watched: false).map(&:show)
    @watched_shows = @user.user_shows.where(watched: true).map(&:show)
    haml :'users/user_detail'
  end

  get '/users' do
    @users = User.all.order(:username)
    haml :'users/all_users'
  end

  helpers do
    def valid_user?(user, params)
      valid = user && user.authenticate(params[:password])
      flash[:message] = 'Invalid username or password.' unless valid
      valid
    end

    def valid_info?(user)
      return true if user.valid?

      message = user.errors.messages.map do |key, ar|
        ar.map{ |value| "#{key} #{value}" }.join(', ')
      end.join(', ') + '.'

      flash[:message] = message
      false
    end
  end
end
