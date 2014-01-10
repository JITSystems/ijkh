#encoding: utf-8

class FreelanceInterface::FreelancersController < FreelanceInterfaceController

	skip_before_filter :require_current_user

	def show
		@freelancer = FreelanceInterface::Freelancer.new

	end

	
	def new
		@freelancer = FreelanceInterface::Freelancer.new
		@tags = FreelanceInterface::Tag.all

		
		# FAKE DATA
		# FreelanceInterface::Tag.delete_all
		# ['Уборка','Ремонт','Телевизоров','Обучение','Седовник','Водопроводчик','Монтажник','Разнорабочий','Уборка','Ремонт','Няня','web design','Ремонт стиральных машин','Ubuntu','twitter','Маляр','wordpress','youtube','Электрик','web 2.0','motion design','work','телефонмастер','турникмен','игра на гитаре','катание на сноуборде'].each do |tag|
		# 	FreelanceInterface::Tag.create!(title: tag, published: true)
		# end

	end

	
	def create
		@freelancer = FreelanceInterfaceFreelancerManager.create(params, current_user)
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