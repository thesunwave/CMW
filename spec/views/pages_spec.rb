require 'rails_helper'

describe 'Pages' do
  
  describe 'Home page' do
    before { visit '/' }

    it "should have the base title" do
      expect(page).to have_title("CMW")
    end
  end
end