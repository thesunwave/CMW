shared_context 'warden' do
  include Warden::Test::Helpers

  before :each do
    Warden.test_mode!
  end

  after :each do
    Warden.test_reset!
  end
end
