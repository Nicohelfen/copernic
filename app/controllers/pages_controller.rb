class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :control_active_user


  def index

  end


end

