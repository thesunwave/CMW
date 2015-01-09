class PostsController < ApplicationController
  before_action :signed_in_user

  def create
  	@post = Post.new(post_params)
  	@post.save
  	redirect_to @post
  end

  def destroy
  end


  private
	def post_params
  		params.require(:posts).permit(:name, :description, :user_id)
  	end
end