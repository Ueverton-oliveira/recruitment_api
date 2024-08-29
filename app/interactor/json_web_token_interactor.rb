class JsonWebTokenInteractor
	include Interactor

	SECRET_KEY = Rails.application.secrets.secret_key_base.to_s


	def call
		case context.action
		when :encode
			context.token = encode(context.payload, context.expiry)
		when :decode
			context.decoded_payload = decode(context.token)
		else
			context.fail!(error: 'Invalid action')
		end
	end

	private

	def encode(payload, exp = 24.hours.from_now)
		payload[:exp] = exp.to_i
		JWT.encode(payload, SECRET_KEY)
	end

	def decode(token)
		JWT.decode(token, SECRET_KEY)[0]
	rescue
		nil
	end
end
