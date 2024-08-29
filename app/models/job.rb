class Job < ApplicationRecord
  include Searchable

  # Associations
  belongs_to :recruiter

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :recruiter_id, presence: true
  

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
