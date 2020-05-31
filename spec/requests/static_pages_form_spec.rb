# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StaticPagesController#form', type: :request do
  include_context "header_footer_examples"
  subject { get privacy_path; response }

  it_behaves_like "ヘッダーとフッターに適切な表示がされる"

  it "お問い合わせ画面にアクセスできる" do
    get form_path
    expect(response).to have_http_status(:success)
  end

  it "お問い合わせ画面からフォーム送信ができる" do
    expect {
      post form_send_inquiry_path,
      params: {
        email: "test@email.com",
        name: "name",
        title: "title",
        content: "content"
      }
    }.to change(ActionMailer::Base.deliveries, :count).by(1)
  end

end