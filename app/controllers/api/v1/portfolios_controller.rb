class Api::V1::PortfoliosController < Api::V1::BaseController
	before_action :authenticate_user!, only: [:create, :update]
	before_filter :find_posts, only: [:show, :update, :delete]

	api :GET, "/", "Show all posts"
	def index
	    portfolios = Portfolio.page(params[:page]).per(PORTFOLIO_PER_PAGE).order(:id).published;
      render_portfolios(portfolios)
	end

  def search_name
      @users = User.search(params[:q]).where(portfolio_id: 0..Float::INFINITY).page(params[:page]).per(PORTFOLIO_PER_PAGE).order(:id)
      render_users(@users)
  end

  if user_signed_in?
      @portfolio = Portfolio.new(params.require(:portfolio).permit(:url, :picture, :picture_cache));
      @user = User.where(id: current_user.id).first

      @portfolio.user_id = current_user.id

      if @portfolio.save
          @user.update(portfolio_id: @portfolio.id)
          redirect_to action: "index"
      else
          render :new
      end
  end

  def create
		@json = JSON.parse(request.body.read)
    @user = User.where(id: current_user.id).first
	    if @portfolio.present?
	      render nothing: true, status: :conflict
      else
        @portfolio = Portfolio.new(params.require(:portfolio).permit(:url, :picture, :picture_cache));
        @portfolio.user_id = current_user.id;
        
  			if @portfolio.save
          @user.update(portfolio_id: @portfolio.id)
  				render json: @portfolio
  			else
  			 	render nothing: true, status: :bad_request
  			end
		end
	end

  def search_perso
      @ville_slug = params[:ville];
      @job_slug = params[:job];
      @ville = Ville.where(slug: @ville_slug).first
      @job = Job.where(slug: @job_slug).first

      if @ville.present? && @job.present?
        @portfolios = Portfolio.joins(:user).where(users: {job_id: @job.id, ville_id: @ville.id}).page(params[:page]).per(PORTFOLIO_PER_PAGE).published;
      else
        not_found
      end

      render_portfolios(@portfolios)
  end


  def category
      category_slug = params[:category];
      @category = Job.where(slug: category_slug).first


      get_portfolios('job_id')
  end


  def ville
      category_slug = params[:ville];
      @category = Ville.where(slug: category_slug).first

      get_portfolios('ville_id')
  end

  def get_portfolios(field)
      if  @category.present?
          portfolios = Portfolio.joins(:user).where(users: {field.to_sym => @category.id}).page(params[:page]).per(PORTFOLIO_PER_PAGE).published;
      else
          not_found
      end
      render_portfolios(portfolios)
  end

  def render_portfolios(portfolios)
    render json: ActiveModel::ArraySerializer.new(
        portfolios,
        each_serializer: Api::V1::PortfolioSerializer,
        root: 'portfolios',
      )
  end

  def render_users(users)
    render json: ActiveModel::ArraySerializer.new(
        users,
        each_serializer: Api::V1::UserSerializer,
        root: 'users',
      )
  end
end
