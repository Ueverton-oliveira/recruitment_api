require 'rails_helper'

RSpec.describe Job, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:recruiter_id) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:skills) }
  it { is_expected.to validate_presence_of :status }


  it 'should validate end_date is after start_date' do
    job = Job.new(
      title: 'Position Ruby on Rails',
      description: 'This is a description.',
      start_date: Date.today,
      end_date: Date.yesterday,
      status: 'active',
      skills: 'Some skills',
      recruiter_id: 1
    )

    expect(job).not_to be_valid
    expect(job.errors[:end_date]).to include('Data deve ser após a data de início')
  end
end
