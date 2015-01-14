# describe 'Settings API:' do
#   include_context 'warden'
#   let (:user)   { FactoryGirl.create(:user) }

#   it_behaves_like 'needs authentication', 'пользователь должен быть авторизован',
#                   :patch, '/auth/settings.json', 
#                   FactoryGirl.create(:user).as_json

#   describe do
#     let! (:user)   { sign_in_user }

#     describe 'Изменяет настройки пользователя: ' do

#       it 'полное обновление настроек' do
#         # объект запроса
#         update_payload = {  
#           first_name: 'first', 
#           last_name: 'name', 
#           links: [
#             'http://link.ru',
#             'http://link1.ru',
#             'https://link2.ru',
#           ],
#           username: 'userurl',
#           email: 'new@email.org',
#           password: 'newpass',
#           password_confirmation: 'newpass',
#           current_password: 'somepass',
#           description: 'long description here',
#           lang: 'en',
#           notifications: {
#             new_personal_message:       1,
#             new_comment_replay:         1,
#             send_new_schedule_to_email: 0,
#             new_mix_comment:            0,
#             mix_onair:                  0,
#             mix_in_schedule:            1
#           }
#         }

#         # подготовливаем ключи ответа
#         response_user_keys = update_payload.as_json.except('password', 'password_confirmation', 'current_password').keys.collect { |k| k.to_s }.push('id', 'avatar_id', 'city_id', 'country_id')
        
#         # делаем запрос
#         patch '/auth/settings.json', { user: update_payload.as_json }
#         expect(json.keys.count).to eq(3)
#         expect(json).to match_format("result", "user", "needs_confirmation")
#         # refactor: проверить значения изменились или нет
#         expect(json['result']).to eq(1)
#         expect(json['user']).to match_format(response_user_keys)
#         # ключ подтверждения 1, так как был изменен email
#         expect(json['needs_confirmation']).to eq(1)
#         expect(response).to have_http_status(:ok)
#       end

#       it 'частичное обновление настроек' do
#         # объект запроса
#         update_payload = {  
#           first_name: 'first', 
#           last_name: 'name', 
#           lang: 'en'
#         }
#         # делаем запрос
#         patch '/auth/settings.json', { user: update_payload.as_json }
#         expect(json.keys.count).to eq(3)
#         expect(json).to match_format("result", "user", "needs_confirmation")
#         expect(json['result']).to eq(1)
#         expect(json['user']['first_name']).to eq(update_payload[:first_name])
#         expect(json['user']['last_name']).to eq(update_payload[:last_name])
#         expect(json['user']['lang']).to eq(update_payload[:lang])
#         # ключ подтверждения 0, так как email не изменялся
#         expect(json['needs_confirmation']).to eq(0)
#         expect(response).to have_http_status(:ok)
#       end

#       it 'обновление уведомлений', focus: :true do
#         # заполняем массив уведомлений
#         create_notifications = create_list(:notification_type, 6)
#         user.add_notification :new_personal_message
#         user.add_notification :new_comment_replay

#         # объект запроса
#         update_payload = {  
#           notifications: {
#             new_personal_message:       1,
#             new_comment_replay:         0,
#             send_new_schedule_to_email: 0,
#             new_mix_comment:            0,
#             mix_onair:                  0,
#             mix_in_schedule:            1
#           }
#         }
#         # делаем запрос
#         patch '/auth/settings.json', { user: update_payload.as_json }
#         puts update_payload.as_json
#         puts json
#         expect(json.keys.count).to eq(3)
#         expect(json).to match_format("result", "user", "needs_confirmation")
#         expect(json['result']).to eq(1)
#         expect(json['user']['notifications']['mix_in_schedule']).to eq('1')
#         expect(json['user']['notifications']['new_comment_replay']).to be_nil
#         # ключ подтверждения 0, так как email не изменялся
#         expect(json['needs_confirmation']).to eq(0)
#         expect(response).to have_http_status(:ok)
#       end

#     end   # describe 'Изменяет настройки пользователя: '

#     it 'не изменяет пароль без текущего пароля' do
#       patch '/auth/settings.json', { user: { password: 'new' } }
#       expect(json.keys.count).to eq(2)
#       expect(json['result']).to eq(0)
#       expect(json['needs_current_password']).to eq(1)
#       expect(response).to have_http_status(:ok)
#     end

#     it 'не изменяет почту без текущего пароля' do
#       patch '/auth/settings.json', { user: { email: 'new@mail.org' } }
#       expect(json.keys.count).to eq(2)
#       expect(json['result']).to eq(0)
#       expect(json['needs_current_password']).to eq(1)
#       expect(response).to have_http_status(:ok)
#     end

#   end   # describe

# end     # 'Registrations API:'