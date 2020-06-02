# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)
#  uid                    :string(255)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  it "email, passwordは必須" do
    expect{ create(:user) }.to change{User.count}.by(1)
    
    user = build(:user, password: nil)
    expect(user).to be_invalid

    user = build(:user, email: nil)
    expect(user).to be_invalid
  end
end
