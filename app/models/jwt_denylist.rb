class JwtDenylist < ApplicationRecord
  def self.jwt_revoked?(jti)
    where(jti: jti).exists?
  end
end
