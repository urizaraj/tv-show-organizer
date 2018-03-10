class UserShowController < ApplicationController
  post '/usershows/new' do
    redirect back unless current_user.id == params[:usershow][:user_id].to_i
    UserShow.create(params[:usershow])
    redirect back
  end

  patch '/usershows/:id' do |id|
    user_show = UserShow.find(id)
    redirect back unless user_show && current_user.id == user_show.user.id
    user_show.toggle!(:watched)
    redirect back
  end

  delete '/usershows/:id' do |id|
    show = Show.find(id)
    redirect to '/shows' unless show
    show.users.delete(User.find(params[:user_id]))
    redirect back
  end
end