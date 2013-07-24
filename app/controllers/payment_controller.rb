class PaymentController < ApplicationController
	def pay
		client = Faye::Client.new('http://localhost:9292/faye')
		client.subscribe("/#{params[:auth_token]}") do |message|
    		puts message.inspect
  			client.publish("/#{params[:auth_token]}", 'text' => 'Yo nigga!')
  		end
	end
end