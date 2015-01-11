require 'feature_helper'

feature 'Восстановление пароля:', js: true do
  let (:user)   { FactoryGirl.create(:user) }
  setup_devise_mailer

  # feature 'Страница забыли пароль:' do
  #   before :each do
  #     visit '/forget-password'
  #     expect(find('h1')).to have_content(t('title.restore_password'))
  #   end

  #   it_behaves_like 'focus_on_field', 'email'

  #   it_behaves_like 'field_email', 'auth.restore_password'

  #   scenario 'отправляет письмо с токеном сброса' do
  #     ActionMailer::Base.deliveries = []  # clean upcoming mail
  #     fill_in 'email', with: user.email
  #     click_button t('auth.restore_password')
  #     expect(find('.alert-box')).to have_content(t('devise.passwords.send_instructions'))
  #     expect(ActionMailer::Base.deliveries.count).to eq(1)
  #   end

  #   scenario 'не отправляет письмо когда email нет в БД' do
  #     ActionMailer::Base.deliveries = []  # clean upcoming mail
  #     fill_in 'email', with: 'fake@mail.com'
  #     click_button t('auth.restore_password')
  #     expect(find('.title')).to have_content(t('validations.email_not_found'))
  #     expect(ActionMailer::Base.deliveries.count).to eq(0)
  #   end
  # end   # 'Забыли пароль:'
  
  # feature 'Изменение пароля:' do
  #   before :each do
  #     user.send_reset_password_instructions
  #     visit '/reset-password/' + user.reset_password_token
  #     expect(find('h1')).to have_content(t('title.reset_password'))
  #   end

  #   it_behaves_like 'focus_on_field', 'password'

  #   it_behaves_like 'field_passwords', 'auth.password_reset_action', [1, 2]
  # end   # 
  
end   # 'Восстановление пароля:'
