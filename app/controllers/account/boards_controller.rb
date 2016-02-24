module Account
  class BoardsController < ApplicationController

    def index

      @pourc = 0.25
      @sr = 680000
      @target = 0.76
      @ca = 0
      @marge =  @target

      if params[:q] == nil
          @srajust = (@ca * (1 - @marge) ) - (@ca * ( 1 - @target) ) + @sr

      else
          @ca = params[:q].to_i
          @marge = (params[:marge].to_f)/100
          @srajust = (@ca * (1 - @marge) ) - (@ca * ( 1 - @target) ) + @sr
          @assiet = @ca-@srajust
          @prime = @assiet*@pourc
          @mass = 181674
          @mois = ((@prime/@mass) * 12 ).round(1)

      end




    end

  private






  end
end
