#encoding: utf-8

class WebInterface::TitlePageController < WebInterfaceController
	skip_before_filter :require_current_user
	layout 'title_page'

	def show
		@news_items_company = WebInterface::NewsItem.where('is_company is true').order('created_at desc')
		@news_items_jkh = WebInterface::NewsItem.where('is_company is not true').order('created_at desc')
		@users = User.all.count
    	@vendors = Vendor.where(is_active: true).count
    	@freelancers = FreelanceInterface::Freelancer.find([13, 14])
	end
end