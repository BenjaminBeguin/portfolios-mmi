class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  	before_action :configure_permitted_parameters, if: :devise_controller?
	before_filter :all_jobs



	def all_jobs
	    @all_jobs = Job.all
	end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :job_id])
  end

  def after_sign_out_path_for(resource)
    "http://www.google.com"
  end

  	def not_found
    	#redirect_to root_path
    	redirect_to "/"   
   end


end
