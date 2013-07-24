class PaymentController < ApplicationController

	def subscribe
		client = Faye::Client.new('http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com:9292/faye')
		client.subscribe("/#{params[:auth_token]}") do |message|
  			logger.info message.inspect
  		end
  		render json: {base_url: "http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com:9292/faye", channel_title: "/#{params[:auth_token]}"}
	end
	def pay
  		render json: {}
	end

	def test
		client = Faye::Client.new('http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com:9292/faye')
		client.publish("/#{params[:auth_token]}", {text: "#{params[:text]}"})
		render json: {thats: "Good"}
	end
end