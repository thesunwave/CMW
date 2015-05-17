class Users::InvitationsController < Devise::InvitationsController

  def update
    UserMailer.send_new_welcome_message(self).deliver_now
  end

end