# frozen_string_literal: true

class FormMailer < ApplicationMailer
  def send_inquiry(inquiry)
    @inquiry = inquiry
    mail(
      subject: "フォームからのお問い合わせ",
      from: "クイズ和同開珎<inquiry@wadokaichin.games>"
    )
  end
end
