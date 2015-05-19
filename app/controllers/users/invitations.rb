class Users::InvitationsController < Devise::InvitationsController

  def new
    super
  end

  def create
    super
  end

  def update
    UserMailer.send_new_welcome_message(self).deliver_now
  end

end