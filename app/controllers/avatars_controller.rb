class AvatarsController < ApplicationController

  def new
    @avatar = Avatar.new

    render partial: 'upload_avatar' if request.wiselinks_partial?
  end

  def create
    avatar = Avatar.new(avatar_params)
    
    if avatar.save
      current_user.avatar = avatar
      if current_user.save
        render json: { response: 'true', id: avatar.id }, status: :ok
      else
        render json: { response: 'false' }, status: 400
      end
    else
      render json: { response: 'false' }, status: 400
    end
  end

  def edit
    @avatar = current_user.avatar
    render partial: 'crop_avatar' if request.wiselinks_partial?
  end

  def update
    @avatar = Avatar.find(params[:id])
    if @avatar.update_attributes(avatar_params)
      render json: { response: 'true' }, status: :ok
    else
      render json: { response: 'false' }, status: 400
    end
  end

private
  def avatar_params
    params.require(:avatar).permit(:avatar, :crop_x, :crop_y, :crop_w, :crop_h)
  end

end