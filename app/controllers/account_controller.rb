#!/bin/env ruby
# encoding: utf-8
class AccountController < ApplicationController
	def index
	end

	def new_recurrent
		@account = Account.new_recurrent_account params
		render 'account/show'
	end

	def hand_switch
		@account = Account.hand_switch params
		render json: {status: "updated"}
	end
	
	def paid_index
		@place_accounts = Account.index_place_account current_user, "= 1"
		render 'place_account/index'
	end

	def unpaid_index
		@place_accounts = Account.index_place_account current_user, "!= 1"
		render 'place_account/index'
	end

	def switch_account_status
		params.merge!(user_id: current_user.id)
		@account = Account.switch_status params
		render 'account/show'
	end

	def pay_bill
		url = Account.pay_bill current_user, params
		render json: {url: url}
	end

	def destroy
		account = Account.find(params[:account_id])
		if account.destroy
			render json: {status: "deleted"}
		end
	end
end