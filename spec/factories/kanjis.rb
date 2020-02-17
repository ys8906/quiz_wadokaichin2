FactoryBot.define do
  factory :kanji do
    sequence(:character)        { "一" }
    sequence(:jis)              { 1 }
    sequence(:joyo)             { 1 }
    sequence(:kanken)           { 10 }
    sequence(:primary_school)   { 1 }
  end
end