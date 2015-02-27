class ComingSoonController < ApplicationController
	before_filter :show_main_forms!

	def index
		@soon_user = SoonUser.new(:email => params[:email])
		if @soon_user.save
		end
	end

end
