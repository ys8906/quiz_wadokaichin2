class Batch

  def generate_quiz_wadokaichin
    # Generate instances
    quiz = GenerateQuizService.new
    twitter = TwitterService.new

    # Generate wadokaichin
    quiz.generate_wadokaichin_random
    text = "TEST TWEET: New Wadokaichin"
    image = "app/assets/images/quiz_wadokaichin/quiz_#{QuizWadokaichin.last.id}.jpg"

    # Tweet
    twitter.tweet(text, image)

    # After
    p "QuizGenerate.wadokaichin executed"
  end

end