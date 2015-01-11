require 'feature_helper'

feature 'Регистрация:', js: true do
  let (:user)   { FactoryGirl.create(:user) }
  setup_devise_mailer

  # before :each do
  #   visit '/signup'
  #   expect(find('h1')).to have_content(t('title.registration'))
  # end

  # it_behaves_like 'focus_on_field', 'email'

  # scenario 'регистрирует пользователя' do
  #   fill_in 'email',                  with: 'fake@mail.com'
  #   fill_in 'password',               with: 'somepass'
  #   fill_in 'password_confirmation',  with: 'somepass'
  #   click_button t('auth.register')
  #   expect(find('h1')).to have_content(t('title.user_settings'))
  # end

  # scenario 'отправляет письмо подтверждения' do
  #   ActionMailer::Base.deliveries = []  # clean upcoming mail
  #   fill_in 'email',                  with: 'fake@mail.com'
  #   fill_in 'password',               with: 'somepass'
  #   fill_in 'password_confirmation',  with: 'somepass'
  #   click_button t('auth.register')
  #   expect(find('h1')).to have_content(t('title.user_settings'))
  #   expect(ActionMailer::Base.deliveries.count).to eq(1)
  # end

  # feature 'Валидация:' do
  #   feature 'Почта:' do
  #     scenario 'не может быть пустой' do
  #       fill_in 'password', with: user.password
  #       fill_in 'password_confirmation', with: user.password
  #       click_button t('auth.register')
  #       expect(find('label.inputWrap:nth-child(1) > div.error > div.title')).to have_content(t('validations.email_invalid'))  
  #     end

  #     it_behaves_like 'field_email', 'auth.register'

  #     scenario "ошибка если email уже есть в БД" do
  #       fill_in 'email',                  with: user.email
  #       fill_in 'password',               with: user.password
  #       fill_in 'password_confirmation',  with: user.password
  #       click_button t('auth.register')
  #       expect(find('label.inputWrap:nth-child(1) > div.error > div.title')).to have_content(t('validations.email_already_in_use'))
  #     end
  #   end # 'Почта:'

  #   feature 'Пароль:' do
  #     it_behaves_like 'field_password', 'auth.register'

  #     it_behaves_like 'field_passwords', 'auth.register'      
  #   end # 'Пароль:'

  # end   # 'Валидация:'
  
end   # 'Регистрация:'
