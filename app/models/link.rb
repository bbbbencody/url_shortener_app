class Link < ActiveRecord::Base
	after_create :generate_slug!

	validate :valid_url

	def to_param
		slug
	end

	def expire!
		self.expired = true
		save
	end

	def increment_uses!
		self.uses += 1
		save
	end

	private

	def valid_url
		if !(url =~ URI::regexp)
			errors.add(:url, "Not a valid URL")
		end
	end

	#slug for shortened urls. Id is good enough to uniquely identify links,
		#and base36 encoding makes them a little shorter. Opting to store the slug instead of
		#recalculating on each request because even though this is a cheap operation, the requirements
		#indicated to prioritize performance, so this helps keep the controller thin at the 
		#cost of a little storage.
		#
		#This also means that if we want to change how we generate slugs, we just make a 
		#change in one place in the code, and it won't break any older shortened urls.
		#
		#Technically I know it's a security risk to expose sequential ID's in url paths like this, 
		#but I don't think it's too much of an issue for this use case.
	def generate_slug!
		self.slug = self.id.to_s(36)
		save
	end 
end
