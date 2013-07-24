class PaymentController < ApplicationController

	def subscribe
		client = Faye::Client.new('http://localhost:9292/faye')
		client.subscribe("/#{params[:auth_token]}") do |message|
    		puts message.inspect
  			client.publish("/#{params[:auth_token]}", 'text' => 'Yo nigga!')
  		end
  		render json: {base_url: "http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com:9292/faye", channel_title: "/#{params[:auth_token]}"}
	end
	def pay
		client = Faye::Client.new('http://localhost:9292/faye')
		client.subscribe("/#{params[:auth_token]}") do |message|
    		puts message.inspect
  			client.publish("/#{params[:auth_token]}", 'text' => 'Yo nigga!')
  		end
  		render json: {base_url: "http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com:9292/faye", channel_title: "/#{params[:auth_token]}"}
	end
end