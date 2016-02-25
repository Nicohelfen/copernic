module Account
  class BoardsController < ApplicationController

    def index
      calculprime
   end

  private

  def calculprime

    @pourc = 0.25
      @sr = 691000
      @target = 0.73
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




  end
end
