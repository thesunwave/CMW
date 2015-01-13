require 'rails_helper'

describe User, :type => :model do

  @email = Faker::Internet.safe_email
  before(:each) { @user = User.new(email: @email) }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match @email
  end

end
