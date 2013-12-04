#encoding: utf-8

class WebInterface::TitlePageController < WebInterfaceController
	skip_before_filter :require_current_user
	layout 'title_page'

	def show
		@news_items = WebInterface::NewsItem.all
		@users = User.all.count
    	@vendors = Vendor.where(is_active: true).count
	end
end