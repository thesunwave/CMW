shared_context 'devise' do
  include Warden::Test::Helpers
  include Devise::TestHelpers

  before :each do
    Warden.test_mode!
    user = FactoryGirl.create(:user)
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['warden'].stub :authenticate! => user
    allow(controller).to receive(:current_user) { user }
  end

  after :each do
    Warden.test_reset!
  end
end
