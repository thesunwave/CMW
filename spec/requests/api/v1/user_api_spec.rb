# describe 'User API:' do

#   describe '/api/v1/users' do

#     describe 'Настройки пользователя:' do
#       include_context 'warden'

#       it_behaves_like 'needs authentication', 'пользователь должен быть авторизован чтобы выполнить запрос',
#                       :get, '/api/v1/users/settings'

#       context do
#         let! (:user)  { sign_in_user }

#         it 'возвращает только объект настроек' do   
#           get '/api/v1/users/settings'
#           expect(json.count).to eq(1)
#         end

#         it_behaves_like 'user settings', 'возвращает настройки текущего пользователя',
#                         :get, '/api/v1/users/settings'
#       end

#     end # describe

#   end   # describe '/api/v1/users'

# end
