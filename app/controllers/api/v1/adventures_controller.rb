module Api
  module V1
    class AdventuresController < ApplicationController
      def index
        @adventures = Adventure.all
        render json: @adventures
      end

      def create
        @adventure = Adventure.find_or_initialize_by(name: adventure_params[:name])
        # check if adventure exist, if not procceed with creation
        if @adventure.new_record?
          @adventure.assign_attributes(adventure_params)
          if @adventure.save
            render json: { message: 'Adventure created successfully', adventure: @adventure }, status: :created
          else
            render json: { errors: @adventure.errors.full_messages }, status: :bad_request
          end
        else
          # if the adventure with the given name already exists render a message
          render json: { message: 'An adventure with the same name already exists', adventure: @adventure },
                 status: :conflict
        end
      end

      def show
        @adventure = Adventure.find(params[:id])
        render json: @adventure
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Adventure not found' }, status: :not_found
      end

      private

      def adventure_params
        params.require(:adventure).permit(:user_id, :name, :picture, :description)
      end
    end
  end
end
