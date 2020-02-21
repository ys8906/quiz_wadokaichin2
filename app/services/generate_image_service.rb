class GenerateImageService
  require 'open-uri'
  require 'uri'

  def initialize
    @bucket_name = "quiz-site-ys"
    @region = "ap-northeast-1"
    @bucket = Aws::S3::Resource.new(
      region: @region,
      access_key_id:     Rails.application.credentials.aws[:access_key_id],
      secret_access_key: Rails.application.credentials.aws[:secret_access_key]
    ).bucket(@bucket_name)
  end

  def generate_quiz_wadokaichin_image(quiz)       # GenerateImageService.new.generate_quiz_wadokaichin_image()
    image_url = URI.escape("https://res.cloudinary.com/dlab9jkaw/image/upload/" +
                          "l_text:Verdana_50_bold:#{quiz.jukugo_right_name.slice(1)},g_east,x_160/" +
                          "l_text:Verdana_50_bold:#{quiz.jukugo_bottom_name.slice(1)},g_south,y_35/" +
                          "l_text:Verdana_50_bold:#{quiz.jukugo_left_name.slice(0)},g_west,x_160/" +
                          "l_text:Verdana_50_bold:#{quiz.jukugo_top_name.slice(0)},g_north,y_35/" +
                          "wadokaichin_cwtzdu.jpg")
    image_file_path = "app/frontend/images/quiz_wadokaichins/#{quiz.id}.jpg"
    open(image_url) do |file|
      open(image_file_path, "wb") do |image|
        image.write(file.read)
      end
      object_name = "wadokaichin/#{quiz.id}.jpg"
      @bucket.object(object_name).upload_file(image_file_path, acl: 'public-read')
      quiz.update(image_url: "https://#{@bucket_name}.s3-#{@region}.amazonaws.com/#{object_name}")
    end
  end

end
