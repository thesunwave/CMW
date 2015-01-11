describe 'Sessions API:' do
  include_context 'warden'
  let(:user)  { FactoryGirl.create(:user) }

  it 'создает сессию с правильными данными и возвращает объект пользователя' do
    post '/auth/login.json', { user: { email: user.email, password: user.password } }
    expect(json.keys.count).to eq(2)
    expect(json['result']).to eq(1)
    expect(json['user']).to match_format(user.as_json.keys.push("roles"))
    expect(response).to have_http_status(:ok)
  end

  it 'возвращает объект пользователя' do
    login_as user, scope: :user
    post '/auth/login.json'
    expect(json.keys.count).to eq(2)
    expect(json['result']).to eq(1)
    expect(json['user']).to match_format(user.as_json.keys.push("roles"))
    expect(response).to have_http_status(:ok)
  end

  describe 'не создает сессию с: ' do

    it_behaves_like 'needs authentication', 'неправильной почтой',
                    :post, '/auth/login.json',
                    { user: { email: 'fake@mail.com', password: FactoryGirl.build(:user).password } }

    it_behaves_like 'needs authentication', 'неправильным паролем',
                    :post, '/auth/login.json',
                    { user: { email: FactoryGirl.build(:user).email, password:'fakepass' } }

    it_behaves_like 'needs authentication', 'неправильными почтой и паролем',
                    :post, '/auth/login.json',
                    { user: { email: 'fake@mail.com', password:'fakepass' } }

    it_behaves_like 'needs authentication', 'пустыми почтой и паролем',
                    :post, '/auth/login.json',
                    { user: { email: '', password:'' } }

    it_behaves_like 'needs authentication', 'пустым запросом',
                    :post, '/auth/login.json'

  end   # 'не авторизует пользователя c: '

  it 'удаляет сессию' do
    login_as user, scope: :user
    delete '/auth/logout.json'
    expect(json.keys.count).to eq(1)
    expect(json['result']).to eq(1)
    expect(response).to have_http_status(:ok)
  end

  it 'не удаляет сессию если её нет' do
    delete '/auth/logout.json'
    expect(json.keys.count).to eq(1)
    expect(json['result']).to eq(0)
    expect(response).to have_http_status(:ok)
  end

  it 'не создаёт сессию если почта не подтверждена' do
    user.update_attributes(confirmed_at: nil)
    post '/auth/login.json', { user: { email: user.email, password: user.password } }
    expect(json.keys.count).to eq(1)
    expect(json['error_key']).to eq('unconfirmed')
    expect(response).to have_http_status(:unauthorized)
  end

end     # 'Sessions API:'