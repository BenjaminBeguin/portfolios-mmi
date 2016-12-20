class UsersController < ApplicationController
	def show
		@user = User.where( slug: params[:slug]).first or not_found
	end

	def index
		@users = User.page(params[:page]).per(PORTFOLIO_PER_PAGE);
	end

  	def category
		@category_slug = params[:category];
		@category = Job.where(slug: @category_slug).first

		get_user('job_id')
	end

	def ville
		@category_slug = params[:ville];
		@category = Ville.where(slug: @category_slug).first

		get_user('ville_id')
		
	end

	def get_user(field)
		if  @category.present?
			@users = User.where(field.to_sym => @category.id).page(params[:page]).per(PORTFOLIO_PER_PAGE);
		else
			not_found
		end
	end
end
