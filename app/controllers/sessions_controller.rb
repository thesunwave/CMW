class SessionsController < ApplicationController

	def new
	end

	def create
	  user = User.find_by(nikname: params[:session][:nikname].downcase)
	  if user && user.authenticate(params[:session][:password])
	  	sign_in user
	  	redirect_to user
	  else
	  	flash.now[:error] = "Неправильный пароль или ник"
	  	render 'new'
	  end
	end

	def destroy
	  sign_out
	  redirect_to root_url
	end
end
