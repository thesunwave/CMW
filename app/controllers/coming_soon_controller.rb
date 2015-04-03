class ComingSoonController < ApplicationController

  before_filter :show_main_forms!

  def index
    @soon_user = SoonUser.new
  end

  def create
    @soon_user = SoonUser.create(soon_user_params)

    respond_to do |format|
      if @soon_user.save
        # format.html { render action: :index }
        format.json { render json: { :type => "success", :message => "Ok" } }
      else
        # format.html { render action: :index }
        format.json { render json: @soon_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def soon_user_params
    params.require(:soon_user).permit(:email)
  end
end
