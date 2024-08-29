require 'rails_helper'

RSpec.describe Submission, type: :model do
  let(:recruiter) { create(:recruiter) }
  let(:job) { create(:job, recruiter: recruiter) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:mobile_phone) }
  it { should validate_presence_of(:resume) }
  it { should validate_presence_of(:job_id) }

  it { should allow_value('ueverton@example.com').for(:email) }
  it { should_not allow_value('invalid_email').for(:email) }

  it { should belong_to(:job) }

  before do
    create(:submission, name: 'Vaga para Landetech', email: 'landetech@example.com', mobile_phone: '1234567890', resume: 'Resume content', job: job)
  end

  it 'does not allow duplicate submissions for the same job and email' do
    duplicate_submission = build(:submission, email: 'landetech@example.com', job: job)
    expect(duplicate_submission).not_to be_valid
    expect(duplicate_submission.errors[:email]).to include('já se candidatou a esta vaga')
  end

  # Note: This test is for the Job model, not Submission. Ensure it's placed in the Job model's spec file.
  it 'should validate end_date is after start_date' do
    invalid_job = build(:job, start_date: Date.today, end_date: Date.yesterday)
    expect(invalid_job).not_to be_valid
    expect(invalid_job.errors[:end_date]).to include('Data deve ser após a data de início')
  end
end
