class ApplicationMailer < ActionMailer::Base
  default from: "user@user.com"

  def form_inquiry(inquiry)
    @inquiry = inquiry
    mail(
      subject: "フォームからのお問い合わせ",
      to:  @inquiry[:email]
    ) do |format|
      format.html
    end
  end

  def user_welcome_mail(user)
    @user = user
    mail(
      subject: "[#{@user.name}さん] ようこそ[サービス名]へ！",
      to:  @user.email
    ) do |format|
      format.html
    end
  end

end
