# spec/requests/api/v1/sessions_controller_spec.rb
require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }

  describe 'POST /api/v1/sessions' do
    it 'creates a session and returns a token with valid credentials' do
      post '/api/v1/sessions', params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key('token')
    end

    it 'returns an error with invalid credentials' do
      post '/api/v1/sessions', params: { email: 'wrong@example.com', password: 'password' }
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end
end
