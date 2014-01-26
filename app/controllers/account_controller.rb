#!/bin/env ruby
# encoding: utf-8
class AccountController < ApplicationController

	def autoset
		# POST api/1.0/account/autoset
		BalanceSetterWorker.perform_async(params)
		render json: {status: "success"}
	end

	def new_recurrent
		# PUT api/1.0/service/:service_id/recurrent_account
		@account = AccountManager.new_recurrent(ServiceManager.get(params[:service_id]))
		render 'account/show'
	end

	def hand_switch
		# PUT api/1.0/account/:account_id/holand_shturval
		@account = AccountManager.hand_switch(current_user, AccountManager.get(params[:account_id]), params[:amount])
		render json: {status: "updated"}
	end
	
	def paid_index
		# GET api/1.0/paid_accounts
		@place_accounts = AccountManager.paid_index(current_user)
		render json: @place_accounts
	end

	def unpaid_index
		# GET api/1.0/unpaid_accounts
		JtIntegrationWorker.perform_async(current_user.id)
		GtIntegrationWorker.perform_async(current_user.id)
		@place_accounts = AccountManager.unpaid_index(current_user)
		render json: @place_accounts
	end
	
	def destroy
		# DELETE api/1.0/account/:account_id
		AccountManager.delete(params[:account_id])
		render json: {status: "deleted"}
	end
end