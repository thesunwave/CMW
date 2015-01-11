require 'feature_helper'

feature 'Вход:', js: true do
  let (:user)   { FactoryGirl.create(:user) }

  # before :each do
  #   visit '/login'
  #   expect(find('h1')).to have_content(t('title.login'))
  # end

  # it_behaves_like 'focus_on_field', 'email'

  # scenario 'должен авторизоваться с правильными данными' do
  #   fill_in 'email',    with: user.email
  #   fill_in 'password', with: user.password
  #   click_button t('auth.login')
  #   expect(find('h1')).to have_content(t('title.scene'))   
  # end

  # scenario 'не авторизуется с неправильными данными' do
  #   fill_in 'email',    with: 'fake@mail.com'
  #   fill_in 'password', with: 'badpass'
  #   click_button t('auth.login')
  #   expect(find('.alert-box')).to have_content(t('errors.unauthenticated'))
  # end

  # feature 'Валидация:' do
    
  #   feature 'Почта:' do
  #     scenario 'не может быть пустой' do
  #       fill_in 'password', with: user.password
  #       click_button t('auth.login')
  #       expect(find('div.error > div.title')).to have_content(t('validations.email_invalid'))  
  #     end

  #     it_behaves_like 'field_email', 'auth.login'
  #   end # 'Почта:'

  #   feature 'Пароль:' do
  #     scenario 'не может быть пустым' do
  #       fill_in 'email',    with: user.email
  #       click_button t('auth.login') 
  #       expect(find('div.error > div.title')).to have_content(t('validations.password_cant_be_less'))  
  #     end
      
  #     it_behaves_like 'field_password', 'auth.login'
  #   end # 'Пароль:'

  # end   # 'Валидация:'
  
end   # 'Вход:'
