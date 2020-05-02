# frozen_string_literal: true

class UsersMailer < ApplicationMailer
  default from: "クイズ和同開珎<no-reply@wadokaichin.games>"

  def send_welcome_mail(user)
    @user = user
    mail(
      subject: "ようこそクイズ和銅開珎へ！",
      to: @user.email, &:html
    )
  end
end
