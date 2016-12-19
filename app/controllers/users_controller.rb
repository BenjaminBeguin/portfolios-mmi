class UsersController < ApplicationController
	def show
		@user = User.where( slug: params[:slug]).first or not_found
	end

	def index
		@users = User.all;
	end

  	def category
		@category_slug = params[:category];
		@category = Job.where(slug: @category_slug).first

		if  @category.present?
			@users = User.where(job_id: @category.id)
		else
			not_found
		end
	end
end
