class Job < ApplicationRecord

	belongs_to :user
		
	validates :label, presence: true
	validates :slug, uniqueness: true


	before_create :add_slug_if_not_exist


	# ------------ Slug ---------------- #

	def add_slug_if_not_exist
	    self.slug = self.to_slug
	end

	def to_slug
		ret = self.label
        ret = ret.strip
        ret.gsub! /['`]/,""
        ret.gsub! /\s*@\s*/, " at "
        ret.gsub! /\s*&\s*/, " and "
        ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'  
        ret.gsub! /_+/,"_"
        ret.gsub! /\A[_\.]+|[_\.]+\z/,""
        ret.split('.').join('_').downcase
    end
end
