class Portfolio < ApplicationRecord
	belongs_to :user
	has_many :likes

	cattr_accessor :current_user

	validates :user_id, presence: true
	validates :url, presence: true, :if => :check_url 

	default_scope { where(published: true) }

	def check_url
		if (self.url)	
			if !self.url.strip.empty?
				uri = URI.parse(self.url)
				if !%w( http https ).include?(uri.scheme)
					errors.add(:url, "not valid  url")
				end				
			end	
		end
	end

end
