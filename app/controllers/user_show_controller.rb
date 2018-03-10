class UserShowController < ApplicationController
  post '/usershows/new' do
    redirect back unless current_user.id == params[:usershow][:user_id].to_i
    UserShow.create(params[:usershow])
    redirect back
  end

  patch '/usershows/:id' do |id|
    show = Show.find(id)
    redirect to '/shows' unless show
    show.user_shows.find_by(user_id: params[:user_id]).toggle!(:watched)
    redirect back
  end

  delete '/usershows/:id' do |id|
    show = Show.find(id)
    redirect to '/shows' unless show
    show.users.delete(User.find(params[:user_id]))
    redirect back
  end
end