# frozen_string_literal: true

class Batch
  require 'slack-notifier'

  def initialize
    @notifier = Slack::Notifier.new(Rails.application.credentials.slack[:webhook_url])
  end

  def generate_quiz_wadokaichin
    # インスタンス生成
    generate_quiz = GenerateQuizService.new
    generate_image = GenerateImageService.new
    twitter = TwitterService.new

    # 和同開珎クイズ生成
    generate_quiz.generate_wadokaichin_random_auto
    quiz = QuizWadokaichin.last

    # クイズ画像生成
    generate_image.generate_quiz_wadokaichin_image(quiz)

    # ツイート
    text = <<-EOC
【毎日更新中】新しいクイズ和銅開珎です！あなたは解けるかな？
https://wadokaichin.games/#{quiz.id}
    EOC
    image = "app/frontend/images/quiz_wadokaichins/#{quiz.id}.jpg"
    twitter.tweet(text, image)

    # 完了報告
    p "#{Time.now}: 和同開珎生成バッチ完了"
  rescue StandardError
    # エラー報告
    @notifier.ping "#{Time.now}: [エラー] #{$ERROR_POSITION}"
  end

  def cron_test
    file = File.open("test/test_#{Time.now}.txt", 'w')
    file.puts Time.now
    p 'cron_test 完了'
    raise
  rescue StandardError
    @notifier.ping "#{Time.now}: [エラー] #{$ERROR_POSITION}"
  end
end
