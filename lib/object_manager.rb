class ObjectManager

	def self.object
		$1.constantize if self.name =~ /^(\w*)Manager/
	end

	def self.get(id)
		object.find(id)
	end

	def self.create(params, user = nil)
		object.create!(params)
	end

	def self.update(params, object)
		object.update_attributes(params)
		object
	end

	def self.delete(id)
		object.find(id).destroy
	end

	def self.index
		object.all
	end
end