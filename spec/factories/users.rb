# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)
#  uid                    :string(255)
#
FactoryBot.define do
  factory :user do
    name       { Faker::Name.name }
    email      { Faker::Internet.email }
    password   { 'password' }

    trait :with_quiz_records do
      after(:create) do |user|
        create_list(:quiz_wadokaichin, 2)
        # 正答したクイズ
        user.quiz_wadokaichin_savedata << build(
          :quiz_wadokaichin_savedatum,
          quiz_wadokaichin_id: QuizWadokaichin.first.id,
          correct: 1
        )
        # 答えを見たクイズ
        user.quiz_wadokaichin_savedata << build(
          :quiz_wadokaichin_savedatum,
          quiz_wadokaichin_id: QuizWadokaichin.second.id,
          correct: 0
        )
      end
    end
  end
end
