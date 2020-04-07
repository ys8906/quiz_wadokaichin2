# frozen_string_literal: true

class FormMailer < ApplicationMailer
  default from: 'user@user.com'

  def send_inquiry(inquiry)
    @inquiry = inquiry
    mail(
      subject: 'フォームからのお問い合わせ',
      to: @inquiry[:email], &:html
    )
  end
end
