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

    def edit       
        if user_signed_in?
            @portfolio = Portfolio.where(user_id: current_user.id).first;
            if !@portfolio
                redirect_to portfolios_new_path 
            end
        else
            not_found
        end
    end

    def update       
        if user_signed_in?
            @porfolio = Portfolio.where(user_id: current_user.id).first
            if @porfolio
                @porfolio.update(params.require(:portfolio).permit(:url));
                if @porfolio.save                    
                    redirect_to edit_user_registration_path
                else
                    render action: 'edit'
                end
            else
                redirect_to new_user_session_path 
            end
        else
            redirect_to new_user_session_path 
        end
    end


end
