class ArticlesController < ApplicationController 
    def index 
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(params.require(:article).permit(:title, :description))
        if @article.save
            flash[:notice] = "Article was created successfully!"
            redirect_to @article
        else
            render 'new'
        end
    end

    def new
        @article = Article.new
    end
end