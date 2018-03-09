class UserController < ApplicationController
  get '/signup' do
    redirect to '/' if logged_in?
    haml :'users/create_user'
  end

  post '/signup' do
    redirect to '/' if logged_in?
    redirect back unless valid_user_info?(params[:user])
    User.create(params[:user])
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

    def valid_user_info?(params)
      if params.values.any?(&:empty?)
        flash[:message] = 'Please fill out all fields'
      elsif !/[A-Za-z0-9\-_]+/.match?(params[:username])
        flash[:message] = 'Username can only contain A-Z, a-z, 0-9, _ and -'
      elsif User.find_by(username: params[:username])
        flash[:message] = 'Username already taken.'
      else
        return true
      end
      false
    end
  end
end
