# frozen_string_literal: true

# == Schema Information
#
# Table name: kanjis
#
#  id             :bigint           not null, primary key
#  character      :string(1)
#  jis            :integer
#  joyo           :integer
#  kanken         :integer
#  primary_school :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Kanji, type: :model do
  before do
    @kanji = create(:kanji)
  end

  it 'is valid factory kanji' do
    expect(@kanji).to be_valid
  end

  it 'is invalid if overlapped' do
    expect(FactoryBot.build(:kanji)).to_not be_valid
  end
end
