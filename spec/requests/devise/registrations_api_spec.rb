describe 'Registrations API:' do
  include_context 'warden'
  setup_devise_mailer
  
  let (:user)   { { user: FactoryGirl.attributes_for(:user) } }

  it 'регистрирует пользователя с правильными данными' do
    post '/auth/settings.json', user.as_json
    expect(json.keys.count).to eq(2)
    # refactor: DRY in sessions and registrations tests
    expect(json['result']).to eq(1)
    expect(json['user']).to match_format("id", "email", "first_name", "last_name", "lang", "city_id", "created_at", "updated_at", "avatar_id", "description", "username", "roles")
    expect(response).to have_http_status(:ok)
  end

  describe 'не регистрирует пользователя с:' do
    it 'неправильными данными' do
      user[:user][:email] = 'broken'
      user[:user][:password_confirmation] += 'new'
      user[:user][:lang] = ''
      post '/auth/settings.json', user.as_json
      expect(json.keys.count).to eq(1)
      expect(json['errors']).to match_format("email", "password_confirmation", "lang")
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'некорректной почтой' do
      user[:user][:email] = 'broken@mail'
      post '/auth/settings.json', user.as_json
      expect(json.keys.count).to eq(1)
      expect(json['errors']).to match_format("email")
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'неправильным подтверждением пароля' do
      user[:user][:password_confirmation] += 'new'
      post '/auth/settings.json', user.as_json
      expect(json.keys.count).to eq(1)
      expect(json['errors']).to match_format("password_confirmation")
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  it 'отправляет письмо с токеном подтверждения' do
    ActionMailer::Base.deliveries = []  # clean upcoming mail
    post '/auth/settings.json', user.as_json
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it 'в письме есть токен' do
    ActionMailer::Base.deliveries = []  # clean upcoming mail
    post '/auth/settings.json', user.as_json
    mail = ActionMailer::Base.deliveries.last
    expect(mail.from.pop).to eq(Rails.application.secrets.email_bot_address)
    expect(mail.to.pop).to eq(user[:user][:email])
    expect(mail.reply_to.pop).to eq(Rails.application.secrets.email_bot_address)
    expect(mail.subject).to eq(t('devise.mailer.confirmation_instructions.subject'))
    expect(mail.content_type).to be_include('text/html')
  end

end     # 'Registrations API:'