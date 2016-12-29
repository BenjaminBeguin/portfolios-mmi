class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :all_jobs
  before_filter :all_villes
	before_filter :all_portfolio_voted

  PORTFOLIO_PER_PAGE = 50;

  def all_portfolio_voted
      @portolio_voted = post_like_unlike
    
  end

  def post_like_unlike
      if user_signed_in?
          portfolios_voted = Like.select(:portfolio_id).where(user_id: current_user.id)
          @portfolio_voted = [];

          portfolios_voted.each do |portfolio_voted|
              @portfolio_voted << portfolio_voted.portfolio_id
          end

          @portfolio_voted            
      else
          @portfolio_voted = [];
      end
  end

	def all_jobs
      @all_jobs = Job.all
  end

  def all_villes
      @all_villes = Ville.all
  end

  def is_admin
      Portfolio.current_user = current_user
      if !user_signed_in? || !current_user.admin
        redirect_to "/" 
      end
  end

  def is_connected
      Portfolio.current_user = current_user
      if !user_signed_in?
        redirect_to "/" 
      end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :job_id, :ville_id, :avatar, :avatar_cache])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :job_id, :ville_id, :avatar, :avatar_cache])
  end


  	def not_found
    	#redirect_to root_path
    	redirect_to "/"   
   end




end
