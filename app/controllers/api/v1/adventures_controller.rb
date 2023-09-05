module Api
  module V1
    class AdventuresController < ApplicationController
      def index
        @adventures = Adventure.all
        render json: @adventures
      end

      def create_adventure
        @user = User.find_by(id: params[:user_id])
        else
          @adventure = Adventure.new(adventure_params)
      
          if @adventure.save
            render json: { message: 'Adventure created successfully', user: @user, adventure: @adventure }, status: :created
          else
            render json: { errors: @user.errors.full_messages }, status: :bad_request
          end
      end

      def adventure_params
        params.require(:adventure).permit(:user_id, :name, :picture, :description)
      end
    end
  end
end
