#encoding: utf-8

class FreelanceInterface::FreelancersController < FreelanceInterfaceController

	skip_before_filter :require_current_user


	# перенаправление в профиль, если объявление уже зарегистрировано

	# before_filter :check_existence, :only => [:new, :create]

	# def check_existence
	# 	@freelancer = FreelanceInterface::Freelancer.where(user_id: current_user.id).first || nil
	# 	if @freelancer
	# 		render 'show', id: @freelancer.id
	# 	else
	# 		@freelancer = FreelanceInterface::Freelancer.new
	# 		render 'new'
	# 	end
	# end

	def index
		# @freelancers = FreelanceInterface::Freelancer.where(published: true)

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
	end

	def premium
		@freelancer = FreelanceInterface::Freelancer.where(user_id: current_user.id).first
	end

	
	def new
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

		
		# # заполнение тестовыми тегами
		# FreelanceInterface::Tag.delete_all
		# ['Уборка','Ремонт','Телевизоров','Обучение','Седовник','Водопроводчик','Монтажник','Разнорабочий','Уборка','Ремонт','Няня','web design','Ремонт стиральных машин','Ubuntu','twitter','Маляр','wordpress','youtube','Электрик','web 2.0','motion design','work','телефонмастер','турникмен','игра на гитаре','катание на сноуборде'].each do |tag|
		# 	FreelanceInterface::Tag.create!(title: tag, published: true)
		# end
	end

	
	def create

		uploader = FreelanceInterfaceUploader.new
  		uploader.store!(params[:freelance_interface_freelancer][:picture_url])

  		user_id = current_user.id

		freelancer_params = {
			name: params[:freelance_interface_freelancer][:name],
 			surname: params[:freelance_interface_freelancer][:surname],
 			phone_number: params[:freelance_interface_freelancer][:phone_number],
 			picture_url: uploader.url,
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

			unless params_custom_tags == []
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
		    		tariff:  { id: 176 },
		    		fields: [{id: 175 }]
		    	},
		    	user_account: freelancer_id,
		    }

		    service = ServiceManager.create(params, current_user)
		    # place.is_active = false
		    
		    
			
			@tags = @freelancer.tags
			@comments = @freelancer.comments
			@comment = @freelancer.comments.new


			render 'show', id: freelancer_id
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
		if @freelancer.destroy
		    render json: nil
		  else
		    render status: 500
		end
	end
	

end