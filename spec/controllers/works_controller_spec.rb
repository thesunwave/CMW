require 'rails_helper'

describe WorksController, :type => :controller do

	describe "GET list" do
		it 'возвращает страницу' do
			get :list
			expect(response).to be_success
			expect(response).to render_template(:list)
			expect(response).to have_http_status(:ok)
		end
	end

end
