class AccountParams < ParamsManager

	def self.create(params, user, service)
		account_params(params, user, service)
	end

private

	def self.account_params(params, user, service)
		a_p = {
			place_id: params[:service][:place_id],
			user_id: user.id,
			amount: 0.0,
			service_id: service.id
		}

		a_p
	end
end