# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'QuizWadokaichinReactions', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/quiz_wadokaichin_reactions/create'
      expect(response).to have_http_status(:success)
    end
  end
end
