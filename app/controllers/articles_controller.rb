class ArticlesController < ApplicationController
    def index 
        @articles = Article.all
        render json: {data: @articles, message: "Articles are fetched successfully"} , status: :ok
    end
    def show
        @article = Article.find_by_id(params[:id])
        render json: {data: @article, message: "Article is fetched successfully"}, status: :ok
    end
    def create 
        @article = Article.new(article_params)
        @article.user = User.first
        if @article.save 
            render json: {data: @article, message: "Article is created successfully"}, status: :created
        else
            render json: {error: @article.errors.full_messages}, status: :unprocessable_entity
        end
    end
    def update 
        @article = Article.find_by_id(params[:id])
        if @article.update(article_params)
            render json: {data: @article, message: "Article updated successfully"}, status: :ok
        else
            render json: {error: @article.errors.full_messages}, status: :unprocessable_entity
        end
    end
    def destroy
        @article = Article.find_by_id(params[:id])
        if @article.destroy
            render json: {message: "Article deleted successfully"}, status: :ok
        else
            render json: {error: @article.errors.full_messages}, status: :unprocessable_entity
        end
    end
    private
    def article_params
        params.require(:article).permit(:title, :description)
    end
end
