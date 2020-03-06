class StaticPagesController < ApplicationController
  def home
  end

  def privacy
  end

  def form
  end

  def send_inquiry
    inquiry = { email: params[:email], name: params[:name], title: params[:title], content: params[:content] }
    begin
      FormMailer.send_inquiry(inquiry).deliver
      flash[:success] = "メッセージを送信しました。ありがとうございます。"
      redirect_back(fallback_location: root_path)
    rescue => exception
      # エラー報告
      @notifier.ping "#{Time.now}: [エラー] #{$@}"
    end
  end
end
