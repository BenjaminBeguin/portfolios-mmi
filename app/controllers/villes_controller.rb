class VillesController < ApplicationController
  def index
		@villes = Ville.all
	end

	def new
		@ville = Ville.new
	end

  	def create 

		#todo : admin      

        @ville = Ville.new(params.require(:ville).permit(:label));
        if @ville.save 
            redirect_to action: "index"
        else
            render :new  
        end

    end
end
