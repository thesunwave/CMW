# shared_examples 'focus_on_field' do |field_name|
#   scenario "при открытии фокус в поле #{field_name}" do
#     expect(page.evaluate_script('document.activeElement.name')).to eq(field_name)
#   end
# end

# shared_examples 'field_email' do |button_caption, validation_message = 'validations.email_invalid'|
#   scenario 'проверка формата адреса' do
#     fill_in 'email', with: 'badmail'
#     click_button t(button_caption)
#     expect(find('label.inputWrap:nth-child(1) > div.error > div.title')).to have_content(t(validation_message))
#     fill_in 'email', with: '.badmail'
#     click_button t(button_caption)
#     expect(find('label.inputWrap:nth-child(1) > div.error > div.title')).to have_content(t(validation_message))
#     fill_in 'email', with: 'mad@badmail'
#     click_button t(button_caption)
#     expect(find('label.inputWrap:nth-child(1) > div.error > div.title')).to have_content(t(validation_message))
#     fill_in 'email', with: 'mad@badmail.'
#     click_button t(button_caption)
#     expect(find('label.inputWrap:nth-child(1) > div.error > div.title')).to have_content(t(validation_message)) 
#     fill_in 'email', with: 'mad@.badmail.com'
#     click_button t(button_caption)
#     expect(find('label.inputWrap:nth-child(1) > div.error > div.title')).to have_content(t(validation_message))  
#   end
# end

# shared_examples 'field_password' do |button_caption|
#   scenario 'не может быть короче 5 символов' do
#     fill_in 'email',    with: user.email
#     fill_in 'password', with: '1234'
#     click_button t(button_caption) 
#     expect(find('label.inputWrap:nth-child(2) > div.error > div.title')).to have_content(t('validations.password_cant_be_less'))  
#   end
# end

# shared_examples 'field_passwords' do |button_caption, child = [2,3]|
#   scenario 'не может быть пустым' do
#     fill_in 'password_confirmation', with: user.password
#     click_button t(button_caption) 
#     expect(find("label.inputWrap:nth-child(#{child[0]}) > div.error > div.title")).to have_content(t('validations.passwords_doesnt_match'))  
#     fill_in 'password', with: user.password
#     fill_in 'password_confirmation', with: ''
#     click_button t(button_caption) 
#     expect(find("label.inputWrap:nth-child(#{child[1]}) > div.error > div.title")).to have_content(t('validations.passwords_doesnt_match'))  
#   end

#   scenario 'пароли должны совпадать' do
#     fill_in 'password', with: '12345'
#     fill_in 'password_confirmation', with: '1234'
#     click_button t(button_caption) 
#     expect(find("label.inputWrap:nth-child(#{child[0]}) > div.error > div.title")).to have_content(t('validations.passwords_doesnt_match'))
#     expect(find("label.inputWrap:nth-child(#{child[1]}) > div.error > div.title")).to have_content(t('validations.passwords_doesnt_match'))
#     fill_in 'password', with: '1234'
#     fill_in 'password_confirmation', with: '12345'
#     click_button t(button_caption) 
#     expect(find("label.inputWrap:nth-child(#{child[0]}) > div.error > div.title")).to have_content(t('validations.passwords_doesnt_match'))  
#     expect(find("label.inputWrap:nth-child(#{child[1]}) > div.error > div.title")).to have_content(t('validations.passwords_doesnt_match'))  
#   end
# end