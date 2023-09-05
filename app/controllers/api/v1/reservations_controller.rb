module Api
  module V1
    class ReservationsController < ApplicationController
      def create
        current_user = User.find(params[:currentUserID])
        adventure = Adventure.find(params[:adventureID])

        reservation = Reservation.new(user_id: current_user.id, adventure_id: adventure.id)

        if reservation.save
          @reservations = Reservation.where(user_id: params[:currentUserID])
          @reservations_array = @reservations.to_a

          render json: { message: 'Reservation created successfully', reservations: @reservations_array },
                 status: :created
        else
          render json: { errors: reservation.errors.full_messages }, status: :bad_request
        end
      end

      def get_reservations
        @reservations = Reservation.where(user_id: params[:currentUserID])
        @reservations_array = @reservations.to_a
        if @reservations
          render json: { message: 'Reservations fetched successfully', reservations: @reservations_array }, status: 200
        else
          render json: { message: 'There are no reservations currently' }, status: :no_data
        end
      end

      def destroy
        reservation = Reservation.find(params[:reservation_id])
        if reservation.destroy
          render json: { message: 'Reservation deleted successful' }, status: 204
        else
          render json: { errors: reservation.errors.full_messages }, status: 401
        end
      end
    end
  end
end
