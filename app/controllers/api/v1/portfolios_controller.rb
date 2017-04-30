class Api::V1::PortfoliosController < Api::V1::BaseController
	before_action :authenticate_user!, only: [:update, :create, :vote]
  skip_before_filter  :verify_authenticity_token
	#before_filter :find_posts, only: [:show, :update, :delete]

	api :GET, "/", "Show all posts"
	def index
	    portfolios = Portfolio.page(params[:page]).per(PORTFOLIO_PER_PAGE).order(:id).published;
      render_portfolios(portfolios)
	end

  def search_name
      @users = User.search(params[:q]).where(portfolio_id: 0..Float::INFINITY).page(params[:page]).per(PORTFOLIO_PER_PAGE).order(:id)
      render_users(@users)
  end

  def create
		@json = JSON.parse(request.body.read)
    @user = User.where(id: current_user.id).first
	    if @portfolio.present?
	      render json: {error: "Portfolio already created"}, status: :conflict
      else
        @portfolio = Portfolio.new(params.require(:portfolio).permit(:url, :picture, :picture_cache));
        @portfolio.user_id = current_user.id;

  			if @portfolio.save
          @ville = Ville.where(id: @portfolio.user.ville_id).first
          @ville.update(have_portfolio: true)
          @user.update(portfolio_id: @portfolio.id)
  				render json: @portfolio
  			else
  			 	render nothing: true, status: :bad_request
  			end
		end
	end

  def update
      @json = JSON.parse(request.body.read)
      @portfolio = Portfolio.where(user_id: current_user.id).first
      if @portfolio
            @portfolio.update(params.require(:portfolio).permit(:url, :picture, :picture_cache));

          if @portfolio.save
              render json: @portfolio
          else
              render body: "error"
          end
      else
          render body: "error"
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

  def vote
      @portfolio = Portfolio.find(params[:id])
      already_voted = Like.where(user_id: current_user.id , portfolio_id: @portfolio.id).first;
      if !already_voted
          @portfolio.increment_like
          @portfolio.user.ville.increment_like
          @vote = Like.create(user_id: current_user.id , portfolio_id: @portfolio.id)
      else
          @portfolio.decrement_like
          @portfolio.user.ville.decrement_like

          already_voted.destroy
      end
      render json: @portfolio
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
