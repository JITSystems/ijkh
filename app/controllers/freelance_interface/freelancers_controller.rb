#encoding: utf-8

class FreelanceInterface::FreelancersController < FreelanceInterfaceController

	skip_before_filter :require_current_user


	# перенаправление в профиль, если объявление уже зарегистрировано

	before_filter :check_existence, :only => :new

	def check_existence
		@freelancer = FreelanceInterface::Freelancer.where(user_id: current_user.id).first || nil
		if @freelancer
			@tags = @freelancer.tags.where(published: true)
			@comments = @freelancer.comments.where(published: true)
			@comment = @freelancer.comments.new
			render 'show', id: @freelancer.id
		else
			@freelancer = FreelanceInterface::Freelancer.new
			tags = FreelanceInterface::Tag.where(published: true).order('title desc')

			@tags_array = []

			tags.each do |tag|
				@tags_array << [tag.title, tag.id]
			end 

			@tags_array = {
				'Существующие категории' => @tags_array,
				'Новые категории' => []
			} 

			render 'new'
		end
	end

	def index
		# @freelancers = FreelanceInterface::Freelancer.where(published: true)

		@top_ten_freelancers = FreelanceInterface::TopTenFreelancer.all
		@top_ten_count = 10 - @top_ten_freelancers.size

		@freelancer = nil
		@freelancer = FreelanceInterface::Freelancer.where(user_id: current_user.id) if current_user 

		@freelancers = FreelanceInterface::Freelancer.all
		@tags =  FreelanceInterface::Tag.where(published: true).order('title asc')
		@tag_sample = @tags.sample
	end

	def show
		@freelancer = FreelanceInterface::Freelancer.find(params[:id])
		@tags = @freelancer.tags.where(published: true)
		@comments = @freelancer.comments.where(published: true)
		@comment = @freelancer.comments.new

		@top_ten_freelancers = FreelanceInterface::TopTenFreelancer.all
		@top_ten_count = 10 - @top_ten_freelancers.size
	end

	def premium
		@freelancer = FreelanceInterface::Freelancer.where(user_id: current_user.id).first
	end

	
	def new

		
		# # заполнение тестовыми тегами
		# FreelanceInterface::Tag.delete_all
		# ['Уборка','Ремонт','Телевизоров','Обучение','Седовник','Водопроводчик','Монтажник','Разнорабочий','Уборка','Ремонт','Няня','web design','Ремонт стиральных машин','Ubuntu','twitter','Маляр','wordpress','youtube','Электрик','web 2.0','motion design','work','телефонмастер','турникмен','игра на гитаре','катание на сноуборде'].each do |tag|
		# 	FreelanceInterface::Tag.create!(title: tag, published: true)
		# end
	end

	
	def create

		uploader = FreelanceInterfaceUploader.new
  		uploader.store!(params[:freelance_interface_freelancer][:picture_url])

  		logger.info uploader

  		user_id = current_user.id

		freelancer_params = {
			name: params[:freelance_interface_freelancer][:name],
 			surname: params[:freelance_interface_freelancer][:surname],
 			phone_number: params[:freelance_interface_freelancer][:phone_number],
 			picture_url: uploader,
			unpublish_at: Date.current() + params[:freelance_interface_freelancer][:unpublish_at].to_i.month,
			published: false,
			user_id: user_id
		}

		params_tags = params[:freelance_interface_freelancer][:tags]
		params_custom_tags = params[:custom_tags]

		@freelancer = FreelanceInterface::Freelancer.create(freelancer_params)
		freelancer_id = @freelancer.id

		if @freelancer.save 
			params_tags.each do |t|
				FreelanceInterface::FreelancerTag.create!({tag_id: t, freelancer_id: freelancer_id})
			end 

			if params_custom_tags && params_custom_tags != []
				params_custom_tags.each do |t|
					tag = FreelanceInterface::Tag.create({title: t, published: false})
					if tag.save 
						FreelanceInterface::FreelancerTag.create!({tag_id: tag.id, freelancer_id: freelancer_id})		
					end 
				end
			end

			place_params = {
				title: 'fi',
				city: 'fi',
				street: 'fi',
				building: 'fi',
				apartment: 'fi',
				is_active: false,
				city_id: 0,
				type_id: 0
			}

			place = PlaceManager.create(place_params, current_user)


			# service[place_id]:1207
			# service[service_type_id]:20
			# service[vendor][id]:144
			# service[tariff][id]:176
			# service[tariff][fields[][175]][id]:175
			# service[user_account]:1000

			 # "service"=>
			 # {
			 # "place_id"=>"168", 
			 # "service_type_id"=>"6", 
			 # "vendor"=>{"id"=>"19"}, 
			 # "tariff"=>{"id"=>"14", 
			 # "fields"=>[{"id"=>"16"}]}, 
			 # "user_account"=>"123456"}

		     service_params = {
		    	service: {
		    		place_id: place.id,
		    		service_type_id: 20,
		    		vendor: { id: 144 },
		    		tariff:  
		    		{ 
		    			id: 176,
		    			fields: [{id: 175 }]
		    		},	
		    		user_account: freelancer_id.to_s
		    	}
		    }

		    service = ServiceManager.create(service_params, current_user)

		    @freelancer.update_attributes!(service_id: service.id)
		    place.update_attributes!(is_active: false)

			
			@tags = @freelancer.tags.where(published: true)
			@comments = @freelancer.comments.where(published: true)
			@comment = @freelancer.comments.new

			amount_total = params[:amount_total]
			account_id = service.account[:id]


			url = pay(account_id, amount_total)
			logger.info url
			# redirect_to url

			redirect_to freelance_interface_freelancer_path(freelancer_id)

		else
			tags = FreelanceInterface::Tag.where(published: true).order('title desc')

			@tags_array = []

			tags.each do |tag|
				@tags_array << [tag.title, tag.id]
			end 

			@tags_array = {
				'Существующие категории' => @tags_array,
				'Новые категории' => []
			} 

			render 'new'
		end
	end


	def edit
		@freelancer = FreelanceInterface::Freelancer.find(params[:id])
	end


	def update
	  @freelancer = FreelanceInterface::Freelancer.find(params[:id])
	 
	  if @freelancer.update_attributes(params[:freelancer])
	    render json: @freelancer.to_json
	  else
	    render status: 500
	  end
	end

	def destroy
		@freelancer = FreelanceInterface::Freelancer.find(params[:id])
		freelancer_tags = FreelanceInterface::FreelancerTag.where(freelancer_id: @freelancer.id)

		@freelancer.tags.where(published: false).each do |t|
			t.destroy
		end
		

		@freelancer.comments.destroy
		freelancer_tags.each do |f_t|
			f_t.destroy
		end

		if @freelancer.destroy
		    render json: nil
		  else
		    render status: 500
		end
	end

protected


	def pay(account_id, amount)
		@account = Account.find(account_id)
		@vendor = @account.service.vendor

		recipe_params = {
			account_id: 	account_id,
			service_id: 	@account.service.id,
			amount: 		amount
		}

		# @recipe = Recipe.create_recipe current_user, recipe_params
		recipe_manager = RecipeManager.new
		@recipe = recipe_manager.create(@account.service, amount)
		merchant_id = '39859'
		user_id = current_user.id
		order_id = @recipe[:id]
		amount = FloatModifier.format(FloatModifier.modify(@recipe[:total]))
		currency = "RUB"
		private_security_key = '7ab9d14e-fb6b-4c78-88c2-002174a8cd88'

		if params[:rebill_anchor] && params[:rebill_anchor] != ''
			po_root_url = "https://secure.payonlinesystem.com/payment/transaction/rebill/"
			rebill_anchor = params[:rebill_anchor]
			security_key_string = "MerchantId=#{merchant_id}&RebillAnchor=#{rebill_anchor}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"
			security_key = Digest::MD5.hexdigest(security_key_string)
			url = "#{po_root_url}?MerchantId=#{merchant_id}&RebillAnchor=#{rebill_anchor}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&ContentType=xml&user_id=#{user_id}"
		else
		# 	po_root_url = "https://secure.payonlinesystem.com/payment/transaction/auth/"
		# 	ip = params[:payment][:ip]
		# 	card_number = params[:payment][:card_number]
		# 	cardholder_name = params[:payment][:cardholder_name]
		# 	email = params[:payment][:email]
		# 	card_exp_date = params[:payment][:card_exp_date]
		# 	card_cvv = params[:payment][:card_cvv]
			
		# 	security_key_string ="MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"
		# 	security_key = Digest::MD5.hexdigest(security_key_string)
			
		# 	payload = "MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&Ip=#{ip}&Email=#{email}&CardHolderName=#{cardholder_name}&CardNumber=#{card_number}&CardExpDate=#{card_exp_date}&CardCvv=#{card_cvv}&ContentType=xml&user_id=#{user_id}"
		# end	

		po_root_url = "https://secure.payonlinesystem.com/ru/payment/"

		# private_security_key = @vendor.psk
		# merchant_id = @vendor.merchant_id
	

		security_key_string ="MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"
		security_key = Digest::MD5.hexdigest(security_key_string)
		url = "#{po_root_url}?MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&user_id=#{user_id}&ReturnURL=https%3A//izkh.ru"
		end

		url
	end
	

end