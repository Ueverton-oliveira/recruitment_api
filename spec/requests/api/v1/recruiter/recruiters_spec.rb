require 'rails_helper'

RSpec.describe 'Api::V1::Recruiter::RecruitersController', type: :request do
  let!(:recruiters) { create_list(:recruiter, 3) }
  let(:recruiter) { recruiters.first }

  describe 'GET /api/v1/recruiter/recruiters' do
    before { get '/api/v1/recruiter/recruiters' }

    it 'returns a list of recruiters' do
      expect(response).to have_http_status(:success)
      expect(json.size).to eq(3)  # Use the json helper here
    end

    it 'returns the correct recruiter data' do
      expect(response).to have_http_status(:success)
      expect(json[0]['id']).to eq(recruiter.id)
    end
  end

  describe 'GET /api/v1/recruiter/recruiters/:id' do
    before { get "/api/v1/recruiter/recruiters/#{recruiter.id}" }

    it 'returns the recruiter' do
      expect(response).to have_http_status(:success)
      expect(json['id']).to eq(recruiter.id)
    end
  end

  describe 'POST /api/v1/recruiter/recruiters' do
    let(:valid_attributes) { { name: 'Ueverton Souza', email: 'ueverton.souza@example.com', password: 'password' } }
    let(:invalid_attributes) { { name: '', email: '', password: '' } }

    context 'when request is valid' do
      before { post '/api/v1/recruiter/recruiters', params: { recruiter: valid_attributes } }

      it 'creates a recruiter' do
        expect(response).to have_http_status(:created)
        expect(json['name']).to eq('Ueverton Souza')
      end
    end

    context 'when request is invalid' do
      before { post '/api/v1/recruiter/recruiters', params: { recruiter: invalid_attributes } }

      it 'does not create a recruiter' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['email']).to include("can't be blank")
      end
    end
  end

  describe 'PATCH /api/v1/recruiter/recruiters/:id' do
    let(:valid_attributes) { { name: 'Ueverton Souza', email: recruiter.email, password: recruiter.password } }
  
    context 'when request is valid' do
      before { patch "/api/v1/recruiter/recruiters/#{recruiter.id}", params: { recruiter: valid_attributes }, headers: headers }
  
      it 'updates the recruiter' do
        expect(response).to have_http_status(:ok)
        expect(json['name']).to eq('Ueverton Souza')
      end
    end
  end  

  describe 'DELETE /api/v1/recruiter/recruiters/:id' do
    before { delete "/api/v1/recruiter/recruiters/#{recruiter.id}" }

    it 'deletes the recruiter' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
