class PreferencesController < ApplicationController

  def edit
    #No routes for update preference, because change reference is on Navbar do not in special view
    @preference_user = Preference.where(:user_id=> current_user).first
    update
  end

  def update
    #Update active compagny in preferences table
    newcompagny = Preference.find(@preference_user)
    if newcompagny != nil
      newcompagny.update(compagny_id: params[:format])
       redirect_to root_path
    else
      redirect_to root_path
    end

  end

end
