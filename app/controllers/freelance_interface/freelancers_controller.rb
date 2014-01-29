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
		@comments = @freelancer.comments
		@comment = @freelancer.comments.new
	end

	
	def new
		@freelancer = FreelanceInterface::Freelancer.new
		tags = FreelanceInterface::Tag.find(:all, order: 'title')

		@tags_array = []

		tags.each do |tag|
			@tags_array << [tag.title, tag.id]
		end 
		
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
 			picture_url: uploader.url
			unpublish_at: Date.current() + params[:freelance_interface_freelancer][:unpublish_at].to_i.month,
			published: false,
			user_id: current_user.id
		}

		@freelancer = FreelanceInterface::Freelancer.create(freelancer_params)

		if @freelancer.save 
			render 'show', id: @freelancer.id
		else
			render 'new'
		end
	end

	
	def edit
		@freelancer = FreelanceInterface::Freelancer.find(params[:id])
	end


	def update
	  @freelancer = FreelanceInterface::Freelancer.find(params[:id])
	 
	  if @freelancer.update_attributes(params[:post])
	    redirect_to :action => :show, id: @freelancer.id
	  else
	    render 'edit'
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