# encoding: utf-8 

class PasswordsController < Devise::PasswordsController
    
    skip_before_filter :require_auth_token

end