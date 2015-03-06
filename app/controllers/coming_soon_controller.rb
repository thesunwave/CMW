class ComingSoonController < ApplicationController
	before_filter :show_main_forms!

	def index
		@soon_user = SoonUser.new
	end

  def create
    @soon_user = SoonUser.create(soon_user_params)
      if @soon_user.save
        redirect_to invite_path
      else
        redirect_to invite_path
      end
  end

private
  def soon_user_params
    params.require(:soon_user).permit(:email)
  end

end
