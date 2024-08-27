class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers

  def current_user
    @current_user ||= User.find_by(id: decoded_token['sub']) if decoded_token
  end

  private

  def decoded_token
    if auth_header.present?
      token = auth_header.split(' ').last
      JWT.decode(token, Rails.application.credentials.devise_secret_key, true, algorithm: 'HS256')[0]
    end
  rescue JWT::DecodeError
    nil
  end

  def auth_header
    request.headers['Authorization']
  end
end
