# frozen_string_literal: true

class StaticPagesController < ApplicationController
  add_breadcrumb '> ホーム', :root_path

  def home; end

  def privacy
    @title = 'プライバシー'
    add_breadcrumb 'プライバシー', form_path
  end

  def form
    @title = 'お問い合わせ'
    add_breadcrumb 'お問い合わせ', privacy_path
  end

  def send_inquiry
    inquiry = { email: params[:email], name: params[:name], title: params[:title], content: params[:content] }
    FormMailer.send_inquiry(inquiry).deliver
    flash[:success] = 'メッセージを送信しました。ありがとうございます。'
    redirect_back(fallback_location: root_path)
  end
end
