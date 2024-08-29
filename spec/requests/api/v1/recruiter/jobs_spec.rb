require 'rails_helper'

RSpec.describe "Api::V1::Recruiter::Jobs", type: :request do
  let!(:jobs) { create_list(:job, 3) }
  let(:job_id) { jobs.first.id }
  let(:valid_attributes) { { title: 'New Job Title', description: 'Updated Description', start_date: '2024-01-01', end_date: '2024-12-31', status: 'active', skills: 'Ruby, Rails', recruiter_id: jobs.first.recruiter_id } }
  let(:invalid_attributes) { { title: '', description: 'Invalid Job', start_date: '', end_date: '', status: 'inactive', skills: 'Python', recruiter_id: jobs.first.recruiter_id } }

  describe 'GET /api/v1/recruiter/jobs' do
    before { get '/api/v1/recruiter/jobs' }

    it 'returns a list of jobs' do
      expect(response).to have_http_status(:success)
      expect(json.size).to eq(3)
    end
  end

  describe 'GET /api/v1/recruiter/jobs/:id' do
    before { get "/api/v1/recruiter/jobs/#{job_id}" }

    it 'returns the job' do
      expect(response).to have_http_status(:success)
      expect(json['id']).to eq(job_id)
    end
  end

  describe 'POST /api/v1/recruiter/jobs' do
    context 'when request is valid' do
      before { post '/api/v1/recruiter/jobs', params: { job: valid_attributes } }

      it 'creates a job' do
        expect(response).to have_http_status(:created)
        expect(json['title']).to eq('New Job Title')
      end
    end

    context 'when request is invalid' do
      before { post '/api/v1/recruiter/jobs', params: { job: invalid_attributes } }

      it 'does not create a job' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['title']).to include("can't be blank")
      end
    end
  end

  describe 'PATCH /api/v1/recruiter/jobs/:id' do
    context 'when request is valid' do
      before { patch "/api/v1/recruiter/jobs/#{job_id}", params: { job: valid_attributes } }

      it 'updates the job' do
        expect(response).to have_http_status(:ok)
        expect(json['title']).to eq('New Job Title')
      end
    end

    context 'when request is invalid' do
      before { patch "/api/v1/recruiter/jobs/#{job_id}", params: { job: invalid_attributes } }

      it 'does not update the job' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['title']).to include("can't be blank")
      end
    end
  end

  describe 'DELETE /api/v1/recruiter/jobs/:id' do
    before { delete "/api/v1/recruiter/jobs/#{job_id}" }

    it 'deletes the job' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
