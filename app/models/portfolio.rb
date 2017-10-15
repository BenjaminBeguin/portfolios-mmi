class Portfolio < ApplicationRecord

	#mount_uploader :picture, PortfolioUploader
	mount_base64_uploader :picture, PortfolioUploader, file_name: -> (u) { u.url.split('.')[0] + rand(0..300).to_s }

	belongs_to :user
	has_many :likes

	cattr_accessor :current_user

	validates :user_id, presence: true, uniqueness: true							
	validates :url, presence: true, :if => :check_url							

	scope :published, -> { where(published: true) }

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


	def increment_like
		update(like: like + 1)
		if ((Time.now - created_at).to_i < 604800)
			update(count: count + 1)
		end
	end

	def increment_visite
		update(visite: visite + 1)
	end

	def decrement_like
		update(like: like - 1)
		if ((Time.now - created_at).to_i < 604800)
			update(count: count - 1)
		end
	end

end
