class User < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	has_many :skills
	has_one :portfolio

	belongs_to :job
	belongs_to :ville

	validates :firstname, presence: true
	validates :lastname, presence: true
	validates :slug, uniqueness: true
	validates :email, presence: true, format: { with: /\w*@\w*\.\w*/ }, uniqueness: true

	before_create :add_slug_if_not_exist


	# ------------ Slug ---------------- #

	def add_slug_if_not_exist
	    self.slug = self.to_slug
	end

	def have_pf
		self.portfolio.present?
	end

	def name
	   self.firstname + " " + self.lastname
	end

	def to_slug
		ret = self.firstname + "_" + self.lastname
        ret = ret.strip
        ret.gsub! /['`]/,""
        ret.gsub! /\s*@\s*/, " at "
        ret.gsub! /\s*&\s*/, " and "
        ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'  
        ret.gsub! /_+/,"_"
        ret.gsub! /\A[_\.]+|[_\.]+\z/,""
        ret.split('.').join('_').downcase
    end


    def increment_visite
		update(visite: visite + 1)
	end

    #-------------- end Slug ------------- #

end
