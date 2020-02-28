class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Callbacks
  after_create :send_welcome_mail

  def send_welcome_mail
    ApplicationMailer.user_welcome_mail(self).deliver
  end

end
