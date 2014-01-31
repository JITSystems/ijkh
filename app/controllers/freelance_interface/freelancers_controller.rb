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


	def show
		@freelancer = FreelanceInterface::Freelancer.find(params[:id])
		@tags = @freelancer.tags.where(published: true)
		@comments = @freelancer.comments.where(published: true)
		@comment = @freelancer.comments.new
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

		freelancer_params = {
			name: params[:freelance_interface_freelancer][:name],
 			surname: params[:freelance_interface_freelancer][:surname],
 			phone_number: params[:freelance_interface_freelancer][:phone_number],
 			picture_url: uploader.url,
			unpublish_at: Date.current() + params[:freelance_interface_freelancer][:unpublish_at].to_i.month,
			published: false,
			user_id: current_user.id
		}

		@freelancer = FreelanceInterface::Freelancer.create(freelancer_params)
		freelancer_id = @freelancer.id

		if @freelancer.save 
			params[:freelance_interface_freelancer][:tags].each do |t|
				FreelanceInterface::FreelancerTag.create!({tag_id: t, freelancer_id: freelancer_id})
			end 
			
			@tags = @freelancer.tags
			@comments = @freelancer.comments
			@comment = @freelancer.comments.new

			render 'show', id: freelancer_id
		else
			render 'new'
		end
	end

	
	def edit
		@freelancer = FreelanceInterface::Freelancer.find(params[:id])
	end


	def update
	  @freelancer = FreelanceInterface::Freelancer.find(params[:id])
	 
	  if @freelancer.update_attributes(params[:freelancer])
	    render json: @freelancer
	  else
	    render status: 500
	  end
	end


	def index
		@freelancers = FreelanceInterface::Freelancer.all
	end


	def destroy
		@freelancer = FreelanceInterface::Freelancer.find(params[:id])

		@freelancer.destroy

		redirect_to action: :index
	end
	

end