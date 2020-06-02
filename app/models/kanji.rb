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
class Kanji < ApplicationRecord
  has_many  :jukugo_kanjis
  validates :character, presence: true, length: { maximum: 1 },
                        uniqueness: { case_sensitive: true }
end
