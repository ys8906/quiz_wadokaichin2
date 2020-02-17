require 'rails_helper'

RSpec.describe QuizWadokaichin, type: :model do
  before do 
    @quiz_wadokaichin = create(:quiz_wadokaichin)
  end

  it "is valid factory quiz_wadokaichin" do
    expect(@quiz_wadokaichin).to be_valid
  end
end
