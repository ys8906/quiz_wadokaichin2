# frozen_string_literal: true

# == Schema Information
#
# Table name: jukugos
#
#  id         :bigint           not null, primary key
#  name       :string(2)
#  reading    :string(255)
#  meaning    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  example    :integer
#
FactoryBot.define do
  factory :jukugo do
    name       { '嗚呼' }
    reading    { 'ああ' }
    meaning    { '物事に深く感じたり驚いたりした気持ちを直接表す語。' }
  end
end
