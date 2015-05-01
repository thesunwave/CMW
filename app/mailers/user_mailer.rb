class UserMailer < ActionMailer::Base
  default from: 'no-reply@cmw.su'

  def send_new_welcome_message(user)
      @user = user
      mail(to: user.email, :subject => "New User created please review and enable.",
        template: "send_new_welcome_message")
  end
end