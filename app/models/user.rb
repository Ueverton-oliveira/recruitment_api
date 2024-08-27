class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  def generate_jwt
    JWT.encode({ sub: id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.devise_secret_key)
  end
end
