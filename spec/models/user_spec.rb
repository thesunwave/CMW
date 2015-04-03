require 'rails_helper'

describe User, :type => :model do

  # @email = Faker::Internet.safe_email
  # before(:each) { @user = User.new(email: @email) }

  before do
    @user = User.new(first_name: "Ivan", last_name: "Ivanov", email: "user@example.com")
  end

  subject { @user }
  
  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match @email
  end

  it { should be_valid }

  describe "это имя не валидно" do
  	before { @user.email = "  " }
  	it { should_not be_valid }
  end
end
