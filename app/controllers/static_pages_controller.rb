class StaticPagesController < ApplicationController
  def home
  end

  def privacy
  end

  def form
  end

  def send_inquiry
    inquiry = { email: params[:email], name: params[:name], title: params[:title], content: params[:content] }
    ApplicationMailer.form_inquiry(inquiry).deliver
    redirect_back(fallback_location: root_path)
  end
end
