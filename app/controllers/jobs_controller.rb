class JobsController < ApplicationController
	def index
		@jobs = Job.all
	end

	def new
		@job = Job.new
	end

  	def create 

		#todo : admin      

        @job = Job.new(params.require(:job).permit(:label));
        if @job.save 
            redirect_to action: "index"
        else
            @categories = Job.all;
            render :new  
        end

    end


end
