class FreelanceInterfaceController < ApplicationController
	skip_before_filter :require_current_user


end