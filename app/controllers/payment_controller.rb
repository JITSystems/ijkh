class PaymentController < ApplicationController
	def pay
		client = Faye::Client.new('http://localhost:9292/faye')
		client.subscribe("/#{params[:auth_token]}") do |message|
    		puts message.inspect
  			client.publish('/server', 'text' => 'Oppa!!')
  		end
	end
end