class Recruiter < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_secure_password
    
  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
