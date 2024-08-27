class Submission < ApplicationRecord
  # Association
  belongs_to :job

  # Validations
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: { scope: :job_id, message: 'já se candidatou a esta vaga' }
  validates :mobile_phone, presence: true
  validates :resume, presence: true
  validates :job_id, presence: true
  validate :unique_submission_per_job

  private

  def unique_submission_per_job
    if Submission.where(job_id: job_id, email: email).exists?
      errors.add(:email, 'já se candidatou a esta vaga')
    end
  end
end
