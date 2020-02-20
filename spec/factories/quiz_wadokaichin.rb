FactoryBot.define do
  factory :quiz_wadokaichin do
    answer     { "一" }
    image      { File.open("spec/factories/image.jpg") }
  end
end