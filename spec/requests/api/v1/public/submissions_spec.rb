require 'rails_helper'

RSpec.describe "Api::V1::Public::Submissions", type: :request do
  let!(:job) { create(:job) }
  let!(:valid_attributes) { { name: 'Ueverton Souza', email: 'ueverton.souza@example.com', mobile_phone: '1234567890', resume: 'Link to resume', job_id: job.id } }
  let!(:invalid_attributes) { { name: '', email: '', mobile_phone: '', resume: '', job_id: nil } }

  describe 'POST /api/v1/public/submissions' do
    context 'when request is valid' do
      before { post '/api/v1/public/submissions', params: { submission: valid_attributes } }

      it 'creates a submission' do
        expect(response).to have_http_status(:created)
        expect(json['name']).to eq('Ueverton Souza')
        expect(json['email']).to eq('ueverton.souza@example.com')
        expect(json['job_id']).to eq(job.id)
      end
    end

    context 'when request is invalid' do
      before { post '/api/v1/public/submissions', params: { submission: invalid_attributes } }

      it 'does not create a submission' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['name']).to include("can't be blank")
        expect(json['email']).to include("can't be blank")
        expect(json['job_id']).to include("can't be blank")
      end
    end
  end
end
