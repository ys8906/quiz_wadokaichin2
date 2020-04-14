# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default to: Rails.application.credentials.email[:gmail]
end
