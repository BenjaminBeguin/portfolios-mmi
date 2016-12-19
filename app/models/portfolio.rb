class Portfolio < ApplicationRecord
	belongs_to :user
	has_many :likes

	validates :user_id, presence: true
	validates :url, presence: true

end
