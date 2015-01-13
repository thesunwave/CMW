require 'rails_helper'

describe Devise::PasswordsController do
  include_context 'devise'
  
  it 'возвращает шаблон восстановления пароля' do
    get :new
    expect(response).to be_success
    expect(response).to render_template(:new)
    expect(response).to have_http_status(:ok)
  end

end
