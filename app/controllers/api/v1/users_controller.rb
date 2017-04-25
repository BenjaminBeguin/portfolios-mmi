class Api::V1::UsersController < Api::V1::BaseController
	before_action :authenticate_user!, only: [:update, :create, :vote]
	#before_filter :find_posts, only: [:show, :update, :delete]

	api :GET, "/", "Show all posts"
	def index
	    users = User.page(params[:page]).per(PORTFOLIO_PER_PAGE).order(:id)
      render_users(users)
	end


  def render_users(users)
    render json: ActiveModel::ArraySerializer.new(
        users,
        each_serializer: Api::V1::UserSerializer,
        root: 'users',
      )
  end
end
