class PortfoliosController < ApplicationController
    def index
        @portfolios = Portfolio.page(params[:page]).per(PORTFOLIO_PER_PAGE).order(:id).published;
    end

    def new
        if user_signed_in?
            if !Portfolio.where(user_id: current_user.id).first
                @portfolio = Portfolio.new
            else
                redirect_to edit_portfolio_path
            end
        else
            redirect_to edit_user_registration_path
        end
    end


    def category
        @category_slug = params[:category];
        @category = Job.where(slug: @category_slug).first

        get_portfolios('job_id')
    end

    def sotd
        @portfolios = Portfolio.page(params[:page]).per(PORTFOLIO_PER_PAGE).order(:id).published.where(siteoftheday: true);
    end



    def ville
        @category_slug = params[:ville];
        @category = Ville.where(slug: @category_slug).first

        get_portfolios('ville_id')
    end

    def search_name
        @users = User.search(params[:q]).where(portfolio_id: 0..Float::INFINITY).page(params[:page]).per(PORTFOLIO_PER_PAGE).order(:id)
    end


    def search_perso
        @ville_slug = params[:ville];
        @job_slug = params[:job];
        @ville = Ville.where(slug: @ville_slug).first
        @job = Job.where(slug: @job_slug).first


        if  @ville.present? && @job.present?
            @portfolios = Portfolio.joins(:user).where(users: {job_id: @job.id, ville_id: @ville.id}).page(params[:page]).per(PORTFOLIO_PER_PAGE).published;
        else
            not_found
        end


    end


    def get_portfolios(field)
        if  @category.present?
            @portfolios = Portfolio.joins(:user).where(users: {field.to_sym => @category.id}).page(params[:page]).per(PORTFOLIO_PER_PAGE).published;
        else
            not_found
        end
    end

    def create
        if user_signed_in?
            @portfolio = Portfolio.new(params.require(:portfolio).permit(:url, :picture, :picture_cache));
            @user = User.where(id: current_user.id).first

            @portfolio.user_id = current_user.id

            if @portfolio.save
                @ville = Ville.where(id: @portfolio.user.ville_id).first
                @ville.update(have_portfolio: true)
                @user.update(portfolio_id: @portfolio.id)

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
        if user_signed_in? || current_user.admin == true
            @porfolio = Portfolio.where(user_id: current_user.id).first

            if current_user.admin == true && params[:portfolio][:id]
                @porfolio = Portfolio.where(id: params[:portfolio][:id]).first
            end

            if @porfolio
                if current_user.admin == true
                    @porfolio.update(params.require(:portfolio).permit(:url, :like, :picture, :picture_cache));
                else
                    @porfolio.update(params.require(:portfolio).permit(:url, :picture, :picture_cache));
                end

                if @porfolio.save
                    if current_user.admin == true
                       redirect_to admin_home_path
                    else
                         redirect_to edit_user_registration_path
                    end
                else
                    if current_user.admin == true
                        redirect_to admin_edit_portfolio_path(id: params[:portfolio][:id])
                    else
                        render action: 'edit'
                    end

                end
            else
                redirect_to root_path
            end
        else
            redirect_to new_user_session_path
        end
    end

    def admin_toggle_publish
        is_admin
        @portfolio_to_update = Portfolio.find_by_id(params[:id]) or not_found
        if @portfolio_to_update.published
            @portfolio_to_update.published = false
        else
            @portfolio_to_update.published = true
        end

        @portfolio_to_update.save!
        redirect_to admin_home_path
    end

    def admin_toggle_sotd
        is_admin
        @portfolio_to_update = Portfolio.find_by_id(params[:id]) or not_found
        if @portfolio_to_update.siteoftheday
            @portfolio_to_update.siteoftheday = false
        else
            @portfolio_to_update.siteoftheday = true
        end

        @portfolio_to_update.save!
        redirect_to admin_home_path
    end



    def vote
        if user_signed_in?
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
            redirect_to '/'
        else
            flash[:error] = 'You need to be signed in to vote'
            redirect_to new_user_session_path
        end
    end


    def add_visite
        @portfolios.find_by_id(params[:id]);
        @portfolio.increment_visite
    end





end
