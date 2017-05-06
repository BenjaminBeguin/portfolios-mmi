class Api::V1::VillesController < Api::V1::BaseController

	api :GET, "/", "Show all posts"
	def index
	    # cities = Ville.where(have_portfolio: true).order(like: :desc)
			# @portfolios = Ville.joins(:user).where(users: {ville_id: ids).page(params[:page]).per(PORTFOLIO_PER_PAGE);
			# render json: @portfolios

			portfolios = Portfolio.all.published;

			ville_with_portfolio_portfolio = []
			ville_with_portfolio_portfolio_id = []

			portfolios.each do |portfolio|
				ville = Ville.where(id: portfolio.user.ville.id).first
				if !ville_with_portfolio_portfolio_id.include? ville.id
					ville_with_portfolio_portfolio << ville
					ville_with_portfolio_portfolio_id << ville.id
				end
			end

		 	render json: ville_with_portfolio_portfolio
	end


	def all
	    cities = Ville.order(:label)
			render json: cities
	end


  def render_cities(cities)
    render json: ActiveModel::ArraySerializer.new(
        cities,
        each_serializer: Api::V1::VilleSerializer,
        root: 'cities',
      )
  end
end
