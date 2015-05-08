module CommentsHelper

  def get_user(comment)
    @user = User.find(comment.user_id)
  end

end
