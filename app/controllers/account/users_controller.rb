module Account
  class UsersController < ApplicationController

    def index
      #Select list of Users for one compagny & Returne list and détail of users.
      @listusers = []
      @userscompagny = Userpermit.where(:compagny_id=> params[:compagny_id])
      @userscompagny.each do |usercompagny|
        @listusers << usercompagny.user_id
      end
      @userslistcompagny =[]
      @listusers.each do |listuser|
        @userslistcompagny << User.where(:id => listuser).first
        end
     end


    def edit
      @user =  User.find(params[:id])
    end

    def update
      @user =  User.find(params[:id])
      set_whitelist_update
      if @user.update(@whitelistupdate)
        flash[:notice] = "User has been updated"
        redirect_to  compagny_account_users_path(params[:compagny_id].to_i)
      else
        flash[:alert] = "User has not been updated? Please try again"
        render :edit
      end
    end

    def new
      # Add New User
      @user = User.new()
    end

    def create
      set_whitelist
      @user = User.new(@whitelist)

       #Delete DEVISE Password control for create user without DEVISE
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end

      @user.save!

      if @user.valid?
        initial_user_permit
        flash[:notice] = "New User successful !"
        redirect_to compagny_account_users_path( params[:compagny_id].to_i)
      else
        flash[:alert] = "Failed to New User !"
        render "new"
      end
    end

private
    def set_whitelist_update
      @whitelistupdate = params.require(:user).permit(:name, :firstname, :email, :active, :manager)
    end

    def set_whitelist
      @whitelist = params.require(:user).permit(:name, :firstname, :email, :active, :manager, :id)
      @whitelist[:password] = '123456789'
      @whitelist[:password_confirmation] = '123456789'
    end

    def initial_user_permit
      @user_id = User.where(:email => params[:user][:email]).first.id
      @compagny_id = params[:compagny_id]
      @whitelist = {:user_id=> @user_id , :compagny_id => @compagny_id, :priority=> true }
      @userpermit = Userpermit.new(@whitelist)
      @userpermit.save
    end

  end
end
