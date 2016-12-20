class JobsController < ApplicationController
	def index
        is_admin
		@jobs = Job.all
	end

	def new
        is_admin
        @job = Job.new
    end

    def edit
        is_admin
        @job = Job.find_by_id(params[:id]) or not_found;
   
    end

    def update
        is_admin
        @job = Job.find(params[:job][:id])
        @job.update(params.require(:job).permit(:label, :slug))

        if @job.save                    
            redirect_to jobs_index_path
        else
            render action: 'edit', :id => @job.id
        end
    end


  	def create 
        is_admin
        @job = Job.new(params.require(:job).permit(:label));
        if @job.save 
            redirect_to action: "index"
        else
            render :new  
        end

    end


end
