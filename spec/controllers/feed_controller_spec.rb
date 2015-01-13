require 'rails_helper'

describe FeedController, :type => :controller do

	describe "GET index" do
		it 'возвращает страницу' do
			get :index
			expect(response).to be_success
			expect(response).to render_template(:index)
			expect(response).to have_http_status(:ok)
		end
	end

end
