# frozen_string_literal: true

# == Schema Information
#
# Table name: jukugos
#
#  id         :bigint           not null, primary key
#  name       :string(2)
#  reading    :string(255)
#  meaning    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  example    :integer
#
require 'rails_helper'

RSpec.describe Jukugo, type: :model do
  before do
    @jukugo = create(:jukugo)
  end

  it 'is valid factory jukugo' do
    expect(@jukugo).to be_valid
  end

  it 'is invalid if overlapped' do
    expect(FactoryBot.build(:jukugo)).to_not be_valid
  end
end
