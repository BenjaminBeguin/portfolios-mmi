class Api::V1::VillesController < Api::V1::BaseController

	api :GET, "/", "Show all posts"
	def index
	    cities = Ville.all.order(like: :desc)
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
