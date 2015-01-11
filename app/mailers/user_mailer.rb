class UserMailer < ActionMailer::Base
  default from: 'no-replay@cmw.su'
  def email
    mail(to: 'zombiqwerty@yandex.ru', subject: 'Mailer')
  end
end