class ArticlesController < ApplicationController
    before_action :verify_user_signed_in
    before_action :set_article , only: [:show, :edit, :update, :destroy]
    before_action :require_same_user, only: [:update, :destroy]
    
    def index
        if (article_params[:author])
            @articles = Article.author(article_params[:author]).paginate(page: params[:page], per_page: 3)
        else
            @articles = Article.recent.paginate(page: params[:page], per_page: 3)
        end
        
        # render json: { data: articles, status: :ok }
    end
    
    def show
    end
    
    def new
        @article = Article.new
    end
    
    def create
        @article = Article.new(new_article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article created successfully"    
            redirect_to @article
        else
            redirect_to new_article_path
            flash[:alert] = "There was an error creating this article"
        end
    end
    
    def edit
    end
    
    def update
        @article = Article.find_by_id(article_params[:id])
        
        if @article.update(new_article_params)
            flash[:notice] = "Article updated successfully"    
            redirect_to @article
        else
            render "edit"
        end
    end
    
    def destroy
        @article.destroy
        redirect_to articles_path
    end
    
    
    def new_article_params
        params.require(:article).permit(:title, :description, :author)
    end
    
    def article_params
        params.permit(:id, :author, :category, :title, :description)
    end
    
    def set_article
        @article = Article.find_by_id(article_params[:id])
    end
    
    def require_same_user
        if @article.user && @article.user.id != current_user.id && !@user.admin
            flash[:alert] = "You can only edit or delete your own articles"
            redirect_to @article
        end
    end
end