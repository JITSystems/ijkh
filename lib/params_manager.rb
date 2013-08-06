class ParamsManager
	
	def self.object
		$1.constantize if self.name =~ /^(\w*)Params/
	end

	def self.params
	end
end