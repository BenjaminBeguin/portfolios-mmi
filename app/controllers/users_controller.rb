class UsersController < ApplicationController
	def show
		@user = User.where( slug: params[:slug]).first or not_found
		@user.increment_visite
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

	def admin_home
		is_admin
		@users = User.page(params[:page]).per(PORTFOLIO_PER_PAGE).order(:id);
	end

	def admin_edit_portfolio
		is_admin
	    @portfolio = Portfolio.where(id: params[:id]).first;
	    if !@portfolio
	        redirect_to portfolios_new_path 
	    end
	end

end
