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
    redirect back unless valid_show_data?(params[:show])
    show = Show.create(params[:show])

    redirect to '/' unless params[:toadd]

    user = current_user
    user.shows << show
    user.save

    redirect to "/shows/#{show.id}"
  end

  get '/shows/:id' do
    @show = Show.find(params[:id])
    redirect to '/shows' unless @show
    @users = @show.users
    @user_show = current_user_show(@show) if logged_in?
    haml :'shows/show_detail'
  end

  get '/shows/:id/edit' do |id|
    @show = Show.find(id)
    redirect to '/shows' unless @show
    haml :'shows/edit_show'
  end

  patch '/shows/:id/edit' do |id|
    show = Show.find(id)
    redirect to '/shows' unless show
    redirect back unless valid_show_data?(params[:show])
    show.update(params[:show])
    redirect to "/shows/#{id}"
  end

  delete '/shows/:id/delete' do |id|
    show = Show.find(id)
    redirect to '/shows' unless show
    show.destroy
    redirect to '/shows'
  end

  helpers do
    def valid_show_data?(params)
      if params[:name].empty?
        flash[:message] = 'Please enter a name.'
      elsif !(1940..2300).include?(params[:year].to_i)
        flash[:message] = 'Please enter a valid year'
      else
        return true
      end
      false
    end
  end
end
