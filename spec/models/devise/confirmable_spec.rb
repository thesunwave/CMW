describe 'Модель пользователя Devise: Подтверждение:' do

  let (:user) { FactoryGirl.create(:user, confirmed_at: '') }
  setup_devise_mailer

  it 'после создания объекта генерируется токен подтверждения' do
    expect(user).to respond_to(:confirmation_token)
    expect(user.confirmation_token).not_to be_nil
  end

  it 'не генерирует один и тот же токен подтверждения для разных пользователей' do
    expect(user).to respond_to(:confirmation_token)
    expect(user.confirmation_token).not_to be_nil
    confirmation_tokens = []
    3.times do
      token = FactoryGirl.create(:user, confirmed_at: '').confirmation_token
      expect(confirmation_tokens).not_to be_include(token)
      confirmation_tokens << token
    end
  end

  it 'подтердив пользователя обновляет confirmed at' do
    expect(user.confirmed_at).to be_nil
    user.confirm!
    expect(user.confirmed_at).not_to be_nil
  end

  it 'очищается токен подтверждения после подтверждения пользователя' do
    expect(user).to respond_to(:confirmation_token)
    user.confirm!
    expect(user.confirmation_token).to be_nil
  end

  it 'проверяет подтвержден ли пользователь или нет' do
    expect(user.confirmed?).to be false
    user.confirm!
    expect(user.confirmed?).to be true
  end

  it 'не подтверждает уже подтвержденного пользователя' do
    user.confirm!
    expect(user.errors[:email]).to be_blank
    expect(user.confirm!).to be false
    expect(user.errors[:email].join).to eq(t('errors.messages.already_confirmed'))
  end

  it 'возвращает новый объект с ошибками при невалидном токене подтверждения' do
    confirmed_user = User.confirm_by_token('invalid_confirmation_token')
    expect(confirmed_user).not_to be_persisted
    expect(confirmed_user.errors[:confirmation_token].join). to eq(t('errors.messages.invalid'))
  end

  it 'возвращает новый объект с ошибками при пустом токене подтверждения' do
    confirmed_user = User.confirm_by_token('')
    expect(confirmed_user).not_to be_persisted
    expect(confirmed_user.errors[:confirmation_token].join). to eq(t('errors.messages.blank'))
  end

  it 'высылает инструкции подтверждения на почту' do
    ActionMailer::Base.deliveries = []  # clean upcoming mail
    user # needs for send confirmation instructions
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it 'добавляет ошибку в массив email если такая почта не найдена' do
    confirmation_user = User.send_confirmation_instructions(email: 'invalid@example.com')
    expect(confirmation_user.errors[:email].join).to eq(t('errors.messages.not_found'))
  end

  it 'присутствуют все поля в письме с инструкциями для подтверждения' do
    ActionMailer::Base.deliveries = []  # clean upcoming mail
    user # needs for send confirmation instructions
    mail = ActionMailer::Base.deliveries.last
    expect(mail.from.pop).to eq(Rails.application.secrets.email_bot_address)
    expect(mail.to.pop).to eq(user.email)
    expect(mail.reply_to.pop).to eq(Rails.application.secrets.email_bot_address)
    expect(mail.subject).to eq(t('devise.mailer.confirmation_instructions.subject'))
    expect(mail.content_type).to be_include('text/html')
  end

end
