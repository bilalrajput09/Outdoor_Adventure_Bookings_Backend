module Api
  module V1
    class AdventuresController < ApplicationController
      def index
        @adventures = Adventure.all
        render json: @adventures
      end
    end
  end
end
