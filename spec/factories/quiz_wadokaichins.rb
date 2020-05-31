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
FactoryBot.define do
  factory :quiz_wadokaichin do
    answer              { "目" }
    image_url           { "https://image.url" }
    association :jukugo_right, factory: :jukugo
    association :jukugo_bottom, factory: :jukugo
    association :jukugo_left, factory: :jukugo
    association :jukugo_top, factory: :jukugo
  end
end
