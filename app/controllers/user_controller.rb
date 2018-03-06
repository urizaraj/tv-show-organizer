class UserController < ApplicationController
  get '/signup' do
    redirect to '/' if logged_in?
    haml :'users/create_user'
  end

  post '/signup' do
    redirect to '/' if logged_in?
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

    unless user && user.authenticate(params[:password])
      flash[:message] = 'Invalid username or password.'
      redirect to('/login')
    end

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
    redirect to '/'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    redirect to '/users' unless @user
    @shows = @user.shows.order(:name)
    haml :'users/user_detail'
  end

  get '/users' do
    @users = User.all.order(:username)
    haml :'users/all_users'
  end
end
