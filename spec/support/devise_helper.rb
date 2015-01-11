module Requests
  module DeviseHelper

    def sign_in_user(params = {})
      user = FactoryGirl.create(:user, params)
      login_as user, :scope => :user
      user
    end

  end
end

RSpec.configure do |config|
  config.include Requests::DeviseHelper, type: :request
end
