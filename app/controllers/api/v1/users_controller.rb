module Api
  module V1
    class UsersController < ApplicationController
      def signup
        user = User.new(user_params)
        if user.save
          render json: { message: 'User created successfully', user: }, status: :created
        else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def login
        @user = User.find_by(username: params[:username])
        if @user
          render json: @user
        else
          render json: { errors: 'Unable to find user.' }, status: 'bad request'
        end
      end

      def signout; end

      def current_user; end

      private

      def user_params
        params.require(:user).permit(:username)
      end
    end
  end
end
