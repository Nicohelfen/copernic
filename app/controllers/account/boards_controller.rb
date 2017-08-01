module Account
  class BoardsController < ApplicationController

    def index

      redirect_to  compagny_account_flows_path(params[:compagny_id].to_i)
    end

private


  end
end
