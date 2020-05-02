# frozen_string_literal: true

class UsersMailer < ApplicationMailer
  default from: 'no-reply@wadokaichin.com'

  def send_welcome_mail(user)
    @user = user
    mail(
      subject: "ようこそクイズ和銅開珍へ！",
      to: @user.email, &:html
    )
  end
end
