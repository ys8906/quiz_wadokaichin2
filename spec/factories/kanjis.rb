# frozen_string_literal: true

FactoryBot.define do
  factory :kanji do
    character        { '一' }
    jis              { 1 }
    joyo             { 1 }
    kanken           { 10 }
    primary_school   { 1 }
  end
end
