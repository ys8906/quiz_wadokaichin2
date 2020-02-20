require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = build(:user)
  end

  it "is valid factory user" do
    expect(@user).to be_valid
  end

end
