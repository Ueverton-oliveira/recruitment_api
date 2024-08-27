require 'rails_helper'

RSpec.describe Submission, type: :model do
  let(:recruiter) { Recruiter.create!(name: 'Recruiter Name', email: 'recruiter@example.com', password: 'password') }
  let(:job) { Job.create!(title: 'Software Engineer', description: 'Job description', start_date: Date.today, end_date: Date.tomorrow, status: :active, skills: 'Ruby, Rails', recruiter_id: recruiter.id) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:mobile_phone) }
  it { should validate_presence_of(:resume) }
  it { should validate_presence_of(:job_id) }

  it { should allow_value('john.doe@example.com').for(:email) }
  it { should_not allow_value('invalid_email').for(:email) }

  it { should belong_to(:job) }

  before do
    Submission.create!(name: 'Vaga para Landetech', email: 'landetech@example.com', mobile_phone: '1234567890', resume: 'Resume content', job_id: job.id)
  end

  it 'does not allow duplicate submissions for the same job and email' do
    duplicate_submission = Submission.new(name: 'Vaga para Landetec', email: 'landetech@example.com', mobile_phone: '0987654321', resume: 'Another resume', job_id: job.id)
    expect(duplicate_submission).not_to be_valid
    expect(duplicate_submission.errors[:email]).to include('já se candidatou a esta vaga')
  end

  it 'should validate end_date is after start_date' do
    job = Job.create(start_date: Date.today, end_date: Date.yesterday)
    expect(job).not_to be_valid
    expect(job.errors[:end_date]).to include("Data deve ser após a data de início")
  end
end
