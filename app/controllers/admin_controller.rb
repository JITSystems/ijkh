class AdminController < ApplicationController

 # before_filter :authenticate_user!
  skip_before_filter :require_auth_token
  layout 'admin'

end