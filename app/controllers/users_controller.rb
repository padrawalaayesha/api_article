class UsersController < ApplicationController
    def show
        # @user = User.find_by_id(params[:id])
        # @articles = @user.articles
        @user = User.includes(:articles).find_by_id(params[:id])
        @articles = @user.articles
        render json: {data: @articles, message:"User is fetched successfully"}, status: :ok
    end
    def index 
        @users = User.all
        render json: {data: @users, message: "Users are fetched successfully"}, status: :ok
    end
    def create
        @user = User.new(user_params)
        if @user.save 
            render json: {data: @user, message: "User created successfully"}, status: :created
        else
            render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end
    def update
        @user = User.find_by_id(params[:id])
        if @user.update(user_params)
            render json: {data: @user, message: "User updated successfully"}, status: :ok
        else
            render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end
    def destroy
        @user = User.find_by_id(params[:id])
        if @user.destroy
            render json: {message: "User deleted successfully"}, status: :ok
        else
            render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end
    private 
    def user_params
        params.require(:user).permit(:username, :email)
    end
end
