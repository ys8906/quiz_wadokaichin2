class TwitterService

  def tweet(something)      # TwitterService.new.tweet()
    # set credentials
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret     = Rails.application.credentials.twitter[:api_secret_key]
      config.access_token        = Rails.application.credentials.twitter[:access_token]
      config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
    end

    # tweet
    client.update_with_media("#{something}", File.new("app/assets/images/quiz_wadokaichin/quiz_6.jpg"))
  end

end
