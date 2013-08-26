class AmountUpdater
	# Updates given amount using several different methods.
	# Can set amount to certain value, nullifies, decreases or increases it.
	# Operates with float type variables
	# TODO: Find a better way to pass amount attribute name

	def initialize(object, amount=:amount)
		@object = object
		@amount = amount
	end
	
	def nullify
		@object.update_attribute(@amount, 0.0)
	end

	def decrease_by(decrease)
		decreased_value = @object.amount - decrease
		@object.update_attribute(@amount, decreased_value)
	end

	def increase_by(increase)
		increased_value = @object.amount + increase
		@object.update_attribute(@amount, increased_value)
	end

	def set_to(value)
		@object.update_attribute(@amount, value)
	end

end