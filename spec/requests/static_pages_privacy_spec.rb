# frozen_string_literal: true

require "rails_helper"

RSpec.describe "StaticPagesController#privacy", type: :request do
  include_context "header_footer_examples"
  subject { get privacy_path; response }

  it_behaves_like "ヘッダーとフッターに適切な表示がされる"

  it "プライバシーポリシーにアクセスできる" do
    expect(subject).to have_http_status(:success)
  end
end