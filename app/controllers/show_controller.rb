class ShowController < ApplicationController
  get '/shows' do
    @shows = Show.all.order(:name)
    haml :'shows/all_shows'
  end

  get '/shows/new' do
    redirect to '/login' unless logged_in?
    haml :'shows/create_show'
  end

  post '/shows/new' do
    show = Show.create(params[:show])

    redirect to '/' unless params[:toadd]

    user = current_user
    user.shows << show
    user.save

    redirect to '/'
  end

  get '/shows/:id' do
    @show = Show.find(params[:id])
    redirect to '/shows' unless @show
    @users = @show.users
    haml :'shows/show_detail'
  end
end
