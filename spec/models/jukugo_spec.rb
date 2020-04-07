# frozen_string_literal: true

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
