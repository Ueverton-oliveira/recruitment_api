class Recruiter < ApplicationRecord
  # Add method to define and authenticate the passwords
  has_secure_password

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
end
