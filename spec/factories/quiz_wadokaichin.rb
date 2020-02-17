FactoryBot.define do
  factory :quiz_wadokaichin do
    sequence(:answer)     { "一" }
    sequence(:image)      { File.open("spec/factories/image.jpg") }
  end
end