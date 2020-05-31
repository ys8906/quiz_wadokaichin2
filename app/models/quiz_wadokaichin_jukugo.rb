# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_wadokaichin_jukugos
#
#  id                  :bigint           not null, primary key
#  quiz_wadokaichin_id :integer
#  jukugo_right_id     :integer
#  jukugo_bottom_id    :integer
#  jukugo_left_id      :integer
#  jukugo_top_id       :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class QuizWadokaichinJukugo < ApplicationRecord
  # Association
  belongs_to :quiz_wadokaichin
  belongs_to :jukugo_right, class_name: 'Jukugo'
  belongs_to :jukugo_bottom, class_name: 'Jukugo'
  belongs_to :jukugo_left, class_name: 'Jukugo'
  belongs_to :jukugo_top, class_name: 'Jukugo'

  # Validation
  validates :quiz_wadokaichin_id, presence: true
  validates :jukugo_right_id, presence: true
  validates :jukugo_bottom_id, presence: true
  validates :jukugo_left_id, presence: true
  validates :jukugo_top_id, presence: true
end
