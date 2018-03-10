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
    user_show = UserShow.find(id)
    redirect back unless user_show && current_user.id == user_show.user.id
    user_show.destroy
    redirect back
  end
end