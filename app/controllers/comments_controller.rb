class CommentsController < ApplicationController

  before_filter :require_user, :only => [:edit, :update, :destroy]

  def create
    @work = Work.find params[:work_id]
    @comment = Comment.new comments_params
    @comment.user_id = current_user.id
    @comment.work_id = @work.id
    if @comment.save
      redirect_to :back, notice: 'Comment was successfully created.'
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:text, :rating)
  end

end
