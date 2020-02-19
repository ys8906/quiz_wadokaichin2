class Batch

  def generate_quiz_wadokaichin
    # Generate instances
    quiz = GenerateQuizService.new
    twitter = TwitterService.new

    # Generate wadokaichin
    quiz.generate_wadokaichin_random_auto
    text = "TEST TWEET: New Wadokaichin"
    image = "app/assets/images/quiz_wadokaichin/quiz_#{QuizWadokaichin.last.id}.jpg"

    # Tweet
    twitter.tweet(text, image)

    # After
    p "QuizGenerate.wadokaichin executed"
  end

  def cron_test
    file = File.open("test_#{Time.now}.txt","w")
    file.puts Time.now
    p "cron_test executed"
  end

end