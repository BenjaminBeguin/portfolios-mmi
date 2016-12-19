class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :all_jobs
	before_filter :all_villes



	def all_jobs
      @all_jobs = Job.all
  end

  def all_villes
      @all_villes = Ville.all
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :job_id, :ville_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :job_id, :ville_id])
  end


  	def not_found
    	#redirect_to root_path
    	redirect_to "/"   
   end




end
