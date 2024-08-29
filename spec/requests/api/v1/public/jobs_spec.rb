require 'rails_helper'

RSpec.describe "Api::V1::Public::Jobs", type: :request do
  let!(:job1) { create(:job, title: 'Software Engineer', description: 'Develop software', skills: 'Ruby, Rails') }
  let!(:job2) { create(:job, title: 'Product Manager', description: 'Manage products', skills: 'Product Management') }

  before do
    Job.__elasticsearch__.create_index!
    Job.__elasticsearch__.refresh_index!
  end

  describe 'GET /api/v1/public/jobs' do
    context 'when query parameter is provided' do
      it 'returns the correct job' do
        get '/api/v1/public/jobs', params: { query: 'Software Engineer' }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Software Engineer')
        expect(response.body).not_to include('Product Manager')
      end
    end

    context 'when query parameter is not provided' do
      it 'returns only active jobs' do
        get '/api/v1/public/jobs'
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Software Engineer')
        expect(response.body).to include('Product Manager')
      end
    end
  end

  describe 'GET /api/v1/public/jobs/:id' do
    it 'returns the job by id' do
      get "/api/v1/public/jobs/#{job1.id}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Software Engineer')
    end
  end
end