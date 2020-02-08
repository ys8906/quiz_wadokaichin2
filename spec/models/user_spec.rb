require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid" do
    user = User.new
    expect(user).to be_valid
  end
end
