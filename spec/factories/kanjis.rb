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
FactoryBot.define do
  factory :kanji do
    character        { '一' }
    jis              { 1 }
    joyo             { 1 }
    kanken           { 10 }
    primary_school   { 1 }
  end
end
