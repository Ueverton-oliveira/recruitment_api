class Job < ApplicationRecord
  # Associations
  belongs_to :recruiter

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :recruiter_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validates :skills, presence: true

  # Custom validation to ensure end_date is after start_date
  validate :end_date_after_start_date

  # Enum
  enum status: { active: 'active', inactive: 'inactive' }

  private

  def end_date_after_start_date
    if end_date.present? && start_date.present? && end_date <= start_date
      errors.add(:end_date, "Data deve ser após a data de início")
    end
  end
end
