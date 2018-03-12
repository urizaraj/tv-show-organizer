class UserShowController < ApplicationController
  post '/usershows/new' do
    redirect back unless current_user.id == params[:usershow][:user_id].to_i
    UserShow.create(params[:usershow])
    redirect back
  end

  patch '/usershows/:id' do |id|
    handle_by_id(id, &:toggle_watched)
  end

  delete '/usershows/:id' do |id|
    handle_by_id(id, &:destroy)
  end

  helpers do
    def handle_by_id(id)
      user_show = UserShow.find(id)
      redirect back unless user_show && current_user.id == user_show.user.id
      yield(user_show)
      redirect back
    end
  end
end
