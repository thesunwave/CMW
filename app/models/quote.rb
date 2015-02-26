class Quote < ActiveRecord::Base
	def self.get_random_quote
		Quote.limit(1).order("RAND()")
	end
end
