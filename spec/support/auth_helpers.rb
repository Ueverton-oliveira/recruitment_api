module AuthHelpers
  def generate_jwt(recruiter)
    JsonWebTokenInteractor.call(action: :encode, payload: { recruiter_id: recruiter.id }).token
  end
end

RSpec.configure do |config|
  config.include AuthHelpers
end
