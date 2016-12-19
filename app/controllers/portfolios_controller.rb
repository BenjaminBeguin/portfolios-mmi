class PortfoliosController < ApplicationController
  def index
  end

  def new
  	@portfolio = Portfolio.new
  end

  	def create       
        if user_signed_in?
            @portfolio = Portfolio.new(params.require(:portfolio).permit(:url));
            @portfolio.user_id = current_user.id 
            if @portfolio.save 
                redirect_to action: "index"
            else
                render :new  
            end
        end
    end


end
