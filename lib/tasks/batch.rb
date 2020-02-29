class Batch
  require 'slack-notifier'

  def initialize
    @notifier = Slack::Notifier.new(Rails.application.credentials.slack[:webhook_url])
  end

  def generate_quiz_wadokaichin
    begin
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
      text = "TEST TWEET: New Wadokaichin"
      image = "app/frontend/images/quiz_wadokaichins/#{QuizWadokaichin.last.id}.jpg"
      twitter.tweet(text, image)
  
      # 完了報告
      p "#{Time.now}: 和同開珎生成バッチ完了"
    rescue => exception
      # エラー報告
      @notifier.ping "#{Time.now}: [エラー] #{$@}"
    end
  end

  def cron_test
    begin
      file = File.open("test/test_#{Time.now}.txt","w")
      file.puts Time.now
      p "cron_test 完了"
      raise
    rescue => exception
      @notifier.ping "#{Time.now}: [エラー] #{$@}"
    end
  end

end