class Api::V1::JobsController < Api::V1::BaseController

	api :GET, "/", "Show all posts"
	def index
	    jobs = Job.all
			render json: jobs
	end


  def render_jobs(jobs)
    render json: ActiveModel::ArraySerializer.new(
        jobs,
        each_serializer: Api::V1::JobSerializer,
        root: 'jobs',
      )
  end
end
