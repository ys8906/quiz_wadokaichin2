# frozen_string_literal: true

class StaticPagesController < ApplicationController
  add_breadcrumb 'ホーム', :root_path

  def home; end

  def privacy
    @title = 'プライバシー'
    add_breadcrumb 'プライバシー', form_path
  end

  def form
    @title = 'フォーム'
    add_breadcrumb 'フォーム', privacy_path
  end

  def send_inquiry
    inquiry = { email: params[:email], name: params[:name], title: params[:title], content: params[:content] }
    begin
      FormMailer.send_inquiry(inquiry).deliver
      flash[:success] = 'メッセージを送信しました。ありがとうございます。'
      redirect_back(fallback_location: root_path)
    rescue StandardError
      # エラー報告
      @notifier.ping "#{Time.now}: [エラー] #{$ERROR_POSITION}"
    end
  end
end
