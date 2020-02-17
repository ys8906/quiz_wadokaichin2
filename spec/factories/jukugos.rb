FactoryBot.define do
  factory :jukugo do
    sequence(:name)       { "嗚呼" }
    sequence(:reading)    { "ああ" }
    sequence(:meaning)    { "物事に深く感じたり驚いたりした気持ちを直接表す語。" }
  end
end