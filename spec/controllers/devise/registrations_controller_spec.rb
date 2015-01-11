describe Devise::ExtendedRegistrationsController do
  include_context 'devise'

  it 'возвращает шаблон регистрации пользователя' do
    get :new
    expect(response).to be_success
    expect(response).to render_template(:new)
    expect(response).to have_http_status(:ok)
  end

  it 'возвращает шаблон изменения настроек пользователя' do
    login_as FactoryGirl.create(:user), scope: :user
    get :edit
    expect(response).to be_success
    expect(response).to render_template(:edit)
    expect(response).to have_http_status(:ok)
  end

  it 'не возвращает шаблон настроек без аутентификации' do
    request.env['warden'].stub(:authenticate!).and_throw(:warden, {:scope => :user})
    get :edit
    expect(response).not_to be_success
    expect(response).to have_http_status(:unauthorized)
  end

end
