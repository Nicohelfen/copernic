module ApplicationHelper

private
  def select_compagny_user
    #In NavBar Select a good compagny context
    if current_user
      @choisecompagny = User.find(current_user.id).compagnies
      if
        params[:compagny_id] == nil
        params[:compagny_id] = Userpermit.where(:user => current_user, :priority => true).first
         if
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

