class AuthenticationController < ApplicationController
  def login
    @recruiter = Recruiter.find_by(email: params[:email])

    if @recruiter&.authenticate(params[:password])
      payload = { recruiter_id: @recruiter.id }
      token = JsonWebTokenInteractor.call(action: :encode, payload: payload)
      time = Time.now + 24.hours
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), name: @recruiter.name }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
