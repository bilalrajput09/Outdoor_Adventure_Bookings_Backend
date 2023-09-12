module Api
  module V1
    class AdventuresController < ApplicationController
      # GET /api/v1/adventures
      # Retrieve a list of all adventures
      def index
        @adventures = Adventure.all
        render json: @adventures
      end

      # POST /api/v1/adventures
      # Create a new adventure or return an existing one if it has the same name
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

      # GET /api/v1/adventures/:id
      # Retrieve details of a specific adventure by its ID
      def show
        @adventure = Adventure.find(params[:id])
        render json: @adventure
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Adventure not found' }, status: :not_found
      end

      # DELETE /api/v1/adventures/:id
      # Delete a specific adventure by its ID
      def destroy
        @adventure = Adventure.find(params[:id])
        @adventure.destroy
        render json: { message: 'Adventure deleted successfully' }
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
