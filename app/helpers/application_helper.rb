module ApplicationHelper
	def without_nav?(name)
		name == "sessions" || name == "passwords" || name == "web_interface/offer"
	end
end