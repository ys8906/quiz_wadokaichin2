# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_wadokaichins
#
#  id                 :bigint           not null, primary key
#  answer             :string(255)
#  image_url          :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  jukugo_right_name  :string(255)
#  jukugo_bottom_name :string(255)
#  jukugo_left_name   :string(255)
#  jukugo_top_name    :string(255)
#  difficulty         :integer
#
class QuizWadokaichin < ApplicationRecord
  # Association
  has_one :quiz_wadokaichin_jukugo, dependent: :destroy
  has_one :jukugo_right, through: :quiz_wadokaichin_jukugo, dependent: :destroy
  has_one :jukugo_bottom, through: :quiz_wadokaichin_jukugo, dependent: :destroy
  has_one :jukugo_left, through: :quiz_wadokaichin_jukugo, dependent: :destroy
  has_one :jukugo_top, through: :quiz_wadokaichin_jukugo, dependent: :destroy
  has_many :quiz_wadokaichin_reactions, dependent: :destroy

  # Validation
  validates :answer, presence: true
end
