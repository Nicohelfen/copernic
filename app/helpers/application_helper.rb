module ApplicationHelper

private
  def select_compagny_user
    #In NavBar Select a good compagny context
      if current_user
        if  User.find(current_user.id).compagnies.count == 0
          @choisecompagny = nil
        else
          @choisecompagny = User.find(current_user.id).compagnies
          if
            # Find a preference priority compagny for User
            params[:compagny_id] == nil
            params[:compagny_id] = Userpermit.where(:user => current_user, :priority => true).first
             if
            # If not Preference priority, choise the first Compagny User
              params[:compagny_id] == nil
              params[:compagny_id] = Userpermit.where(:user => current_user).first.compagny_id
              @choisecompagny = User.find(current_user.id).compagnies
              else
            params[:compagny_id] = Userpermit.where(:user => current_user, :priority => true).first.compagny_id
            @choisecompagny = User.find(current_user.id).compagnies
              end
          end
        end
      end
    end



end

