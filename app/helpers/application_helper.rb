module ApplicationHelper

private
  def select_compagny_user
    #In NavBar Select a good compagny context
    if current_user
      @choisecompagny = Userpermit.where(:user_id => current_user.id)
    end
  end

  def preference_user
    #Change Compagny context for user
    if current_user
      @preference_user = Preference.where(:user_id=> current_user).first
      active_preference
        if @preference_user == []
          @preference_user = Userpermit.where(:user_id => current_user.id).first
          Preference.create(compagny_id: @preference_user.compagny_id, user_id: @preference_user.user_id)
      active_preference
        end
    end
  end

  def active_preference
    #Change Compagny context for user
    @active_preference = Compagny.find(@preference_user.compagny_id)
  end

end

