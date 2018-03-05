class UserController < ApplicationController
  get '/signup' do
    haml :'users/create_user'
  end

  post '/signup' do
    User.create(params[:user])
    redirect to '/login'
  end

  get '/login' do
    haml :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    redirect to('/login') unless user && user.authenticate(params[:password])

    session[:user_id] = user.id
    flash[:message] = "Welcome, #{user.username}."
    redirect to '/'
  end

  get '/logout' do
    session.clear
    redirect to('/login')
  end

  get '/manage' do
    @shows = Show.all
    haml :'users/manage_shows'
  end
end
