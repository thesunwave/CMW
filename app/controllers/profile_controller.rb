class ProfileController < ApplicationController
  def index
  end

  def show
    @user = User.where(username: params[:username]).first
  end
end
