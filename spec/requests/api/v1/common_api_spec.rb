describe 'Common API:' do  
  describe '/api/v1/check' do

    describe 'Проверка на существование email в БД:' do
      let(:user) { FactoryGirl.create(:user) }

      it 'должен возвращать 0 при существоании email в БД' do
        post '/api/v1/check/email', { email: user.email }
        expect(json['result']).to eq(0)
        expect(json.keys.count).to eq(1)
      end

      it 'должен возвращать 1 при отсутствии email в БД' do
        post '/api/v1/check/email', { email: user.email+'free' }
        expect(json['result']).to eq(1)
        expect(json.keys.count).to eq(1)
      end
    end   # describe
    

    describe 'Проверка на существование username в БД:' do
      include_context 'warden'
      let(:user)  { sign_in_user(username: 'testuser') }

      it_behaves_like 'needs authentication', 'пользователь должен быть авторизован чтобы выполнить запрос',
                      :post, '/api/v1/check/username',
                      { username: 'username' }

      it 'должен возвращать 0 при существоании username в БД' do
        post '/api/v1/check/username', { username: user.username }
        expect(json['result']).to eq(0)
        expect(json.keys.count).to eq(1)
      end

      it 'должен возвращать 1 при отсутствии username в БД' do
        post '/api/v1/check/username', { username: user.username+'free' }
        expect(json['result']).to eq(1)
        expect(json.keys.count).to eq(1)
      end
    end # describe

  end   # describe '/api/v1/check'


  describe '/api/v1/get' do

    describe 'Получить текущую локаль в формате json:' do
      it 'должен возвращать локаль :ru' do
        I18n.locale = :ru
        get '/api/v1/get/locale'
        expect(json).to match_format('errors', 'validation', 'devise')
      end

      it 'должен возвращать локаль :en' do
        I18n.locale = :en
        get '/api/v1/get/locale'
        expect(json).to match_format('errors', 'validation', 'devise')
      end
    end # 'Получить текущую локаль в формате json:'

  end   # '/api/v1/get'

end
