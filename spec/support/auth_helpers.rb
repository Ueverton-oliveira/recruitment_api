module AuthHelpers
  def authenticate_recruiter(recruiter)
    payload = { recruiter_id: recruiter.id }
    result = JsonWebTokenInteractor.call(action: :encode, payload: payload)
    result.token
  end
end