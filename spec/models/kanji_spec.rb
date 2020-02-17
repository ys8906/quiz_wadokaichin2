require 'rails_helper'

RSpec.describe Kanji, type: :model do
  before do 
    @kanji = create(:kanji)
  end

  it "is valid factory kanji" do
    expect(@kanji).to be_valid
  end

  it "is invalid if overlapped" do
    expect(FactoryBot.build(:kanji)).to_not be_valid
  end

end
