# frozen_string_literal: true

class UsersMailer < ApplicationMailer
  default from: 'user@user.com'

  def send_welcome_mail(user)
    @user = user
    mail(
      subject: "[#{@user.name}さん] ようこそ[サービス名]へ！",
      to: @user.email, &:html
    )
  end
end
