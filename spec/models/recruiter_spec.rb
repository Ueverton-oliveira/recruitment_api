require 'rails_helper'

RSpec.describe Recruiter, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
end
