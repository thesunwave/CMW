class CommentsController < ApplicationController

  before_action :require_user, :only => [:create, :edit, :update, :destroy]

  def create
    work = Work.find(params[:work_id])
    comment = work.comments.build(comments_params)
    comment.user = current_user
    if comment.save
      redirect_to :back, notice: 'Comment was successfully created.'
    else
      redirect_to :back, alert: "Comment don't be empty"
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:text, :rating)
  end

end
