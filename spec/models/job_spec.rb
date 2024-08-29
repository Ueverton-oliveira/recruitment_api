require 'rails_helper'

RSpec.describe Job, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:recruiter_id) }
  it { is_expected.to belong_to :recruiter }
  

  it 'should validate end_date is after start_date' do
    job = build(:job, start_date: Date.today, end_date: Date.yesterday)

    expect(job).not_to be_valid
    expect(job.errors[:end_date]).to include('Data deve ser após a data de início')
  end
end
