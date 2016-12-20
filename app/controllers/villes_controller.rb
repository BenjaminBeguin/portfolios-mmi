class VillesController < ApplicationController
  def index
		@villes = Ville.all
	end

	def new
		@ville = Ville.new
	end

  def edit
      is_admin
      @ville = Ville.find_by_id(params[:id]) or not_found;
  
  end

  def update
      is_admin
      @ville = Ville.find(params[:ville][:id])
      @ville.update(params.require(:ville).permit(:label, :slug))

      if @ville.save                    
          redirect_to villes_index_path
      else
          render action: 'edit', :id => @ville.id
      end
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
