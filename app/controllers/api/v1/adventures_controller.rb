module Api
  module V1
    class AdventuresController < ApplicationController
      def index
        @adventures = Adventure.all
        render json: @adventures
      end

      def create
        @adventure = Adventure.new(adventure_params)
        @adventure.inspect
        if @adventure.save
          render json: { message: 'Adventure created successfully', adventure: @adventure }, status: :created
        else
          render json: { errors: @adventure.errors.full_messages }, status: :bad_request
        end
      end
      
      private
      
      def adventure_params
        params.require(:adventure).permit(:user_id, :name, :picture, :description)
      end      
    end
  end
end
