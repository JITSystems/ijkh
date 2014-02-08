#encoding: utf-8

class FreelanceInterface::FreelancersController < FreelanceInterfaceController

	skip_before_filter :require_current_user


	# перенаправление в профиль, если объявление уже зарегистрировано

	before_filter :check_existence, :only => :new

	def check_existence
		unless current_user
			redirect_to login_path
			return nil
		end

		@freelancer = FreelanceInterface::Freelancer.where(user_id: current_user.id).first || nil
		if @freelancer
			@tags = @freelancer.tags.where(published: true)
			@comments = @freelancer.comments.where(published: true)
			@comment = @freelancer.comments.new

			@top_ten_freelancers = FreelanceInterface::TopTenFreelancer.all
			@top_ten_count = 10 - @top_ten_freelancers.size

			render 'show', id: @freelancer.id
		else
			@freelancer = FreelanceInterface::Freelancer.new
		
			@top_ten_freelancers = FreelanceInterface::TopTenFreelancer.all
			@top_ten_count = 10 - @top_ten_freelancers.size
		

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
		# @freelancers = FreelanceInterface::Freelancer.all
		@freelancers = FreelanceInterface::Freelancer.where(published: true).order('raiting asc')

		@top_ten_freelancers = FreelanceInterface::TopTenFreelancer.where("unpublish_at > ?", Date.today)
		@top_ten_count = 10 - @top_ten_freelancers.size

		@freelancer = nil
		@freelancer = FreelanceInterface::Freelancer.where(user_id: current_user.id) if current_user 

		
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
		@tags = @freelancer.tags

		@premium = FreelanceInterface::TopFourFreelancer.new
	end

	def pay_for_premium

		amount_total = params[:amount_total]
		number_of_month = params[:number_of_month]
		tags = params[:tag][:values]
		freelancer = FreelanceInterface::Freelancer.where(user_id: current_user.id).first
		service = freelancer.service
		account_id = service.account[:id]

		pay_data = pay(account_id, amount_total)

		tags.each do |t|
			tag_params = {
				tag_id: t, 
				freelancer_id: freelancer.id, 
				recipe_id: pay_data[:recipe_id], 
				number_of_month: number_of_month
			}

			FreelanceInterface::TopFourFreelancer.create!(tag_params)
		end 

		redirect_to pay_data[:url]

		# logger.info pay_data
		# render json: pay_data[:url]
		# render status: 200
	end

	
	def new

		# # заполнение тестовыми тегами
		# FreelanceInterface::Tag.delete_all
		# ['Уборка','Ремонт','Телевизоров','Обучение','Седовник','Водопроводчик','Монтажник','Разнорабочий','Уборка','Ремонт','Няня','web design','Ремонт стиральных машин','Ubuntu','twitter','Маляр','wordpress','youtube','Электрик','web 2.0','motion design','work','телефонмастер','турникмен','игра на гитаре','катание на сноуборде'].each do |tag|
		# 	FreelanceInterface::Tag.create!(title: tag, published: true)
		# end
	end

	
	def create

		params_tags = params[:freelance_interface_freelancer][:tags]
		params_custom_tags = params[:custom_tags]	


		# uploader = FreelanceInterfaceUploader.new
  		# uploader.store!(params[:freelance_interface_freelancer][:picture_url])

 		

  		user_id = current_user.id



		freelancer_params = {
			# unpublish_at: Date.current() + params[:freelance_interface_freelancer][:unpublish_at].to_i.month,
			name: params[:freelance_interface_freelancer][:name],
 			surname: params[:freelance_interface_freelancer][:surname],
 			phone_number: params[:freelance_interface_freelancer][:phone_number],
 			# picture_url: uploader,
			published: false,
			user_id: user_id,
			number_of_month: params[:freelance_interface_freelancer][:number_of_month]
		}



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

		@freelancer.picture_url = params[:freelance_interface_freelancer][:picture_url]
		@freelancer.picture_url = @freelancer.picture_url.identifier
		@freelancer.save!
		logger.info @freelancer
		logger.info @freelancer.picture_url
		

  		 

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

			@top_ten_freelancers = FreelanceInterface::TopTenFreelancer.all
			@top_ten_count = 10 - @top_ten_freelancers.size

			amount_total = params[:amount_total]
			account_id = service.account[:id]


			pay_data = pay(account_id, amount_total)

			@freelancer.update_attributes(recipe_id: pay_data[:recipe_id])

			if params[:freelance_interface_freelancer][:top_ten_freelancer].to_i == 1

				top_ten_params = {
					freelancer_id: freelancer_id, 
					recipe_id: pay_data[:recipe_id], 
					number_of_month: params[:freelance_interface_freelancer][:number_of_month]
				}

				FreelanceInterface::TopTenFreelancer.create!(top_ten_params)
				
			end			

			logger.info pay_data

			
			redirect_to pay_data[:url]

			# redirect_to freelance_interface_freelancer_path(freelancer_id)

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
		
		if @freelancer.top_ten_freelancer
			@freelancer.top_ten_freelancer.destroy
		end

		 if @freelancer.top_four_freelancer
			@freelancer.top_four_freelancer.each do |t_f|
				t_f.destroy
			end	
		end

		if @freelancer.comments	
			@freelancer.comments.each do |c|
				c.destroy
			end
		end

		freelancer_tags.each do |f_t|
			f_t.destroy
		end

		if @freelancer.destroy
		    render js: "alert('OK')";
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
		po_root_url = "https://secure.payonlinesystem.com/ru/payment/"

		# private_security_key = @vendor.psk
		# merchant_id = @vendor.merchant_id
	

		security_key_string ="MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"
		security_key = Digest::MD5.hexdigest(security_key_string)
		url = "#{po_root_url}?MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&user_id=#{user_id}&ReturnURL=https%3A//izkh.ru/freelance_interface/freelancers/new"
		end

		result = { url: url, recipe_id: order_id }
		result
	end
	

end