collection @freelance_categories

attributes :id, :title, :description

child :freelancers => :freelancer do
	extends 'freelancer/index'
end