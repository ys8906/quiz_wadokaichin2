# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_wadokaichin_savedata
#
#  id                  :bigint           not null, primary key
#  user_id             :integer
#  quiz_wadokaichin_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  correct             :integer          default(0), not null
#
FactoryBot.define do
  factory :quiz_wadokaichin_savedatum do
    association   :user
    association   :quiz_wadokaichin
  end
end
