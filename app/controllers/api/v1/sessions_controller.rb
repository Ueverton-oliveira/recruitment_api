class Api::V1::SessionsController < ApplicationController
  # POST /api/v1/sessions
  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      token = user.generate_jwt
      render json: { token: token }, status: :created
    else
      render json: { errors: ['Invalid credentials'] }, status: :unauthorized
    end
  end

  # DELETE /api/v1/sessions
  def destroy
    if current_user
      token = request.headers['Authorization']&.split(' ')&.last
      if token
        JwtDenylist.create(jti: token, exp: 1.day.from_now)
        head :no_content
      else
        render json: { errors: ['Token missing'] }, status: :unprocessable_entity
      end
    else
      render json: { errors: ['Not Authorized'] }, status: :unauthorized
    end
  end
end
