module Account
require 'pipedrive-ruby'

  class OrganizationsController < ApplicationController

    before_action :pipedrive_authenticate

    def index
      # pipedrive_add_new_organization
      # @organizations = Organization.where(:active_flag=> true)
      @organizations =  (Organization.where(:active_flag=> true).where(:compagny_id=> params[:compagny_id].to_i)).sort_by{ |m| m[:name] }

    end

    def show
      @organization = Organization.find(params[:id])
      @persons = Person.where(:organization_id=>params[:id])

    end

    def edit

      @urlorigin = "http://#{@_env["HTTP_HOST"]}/compagny/#{params[:compagny_id]}/account/persons"

      if @_env["HTTP_REFERER"] != @urlorigin
        @organization = Organization.find(params[:id])
      else
        @organization = Organization.find(Person.find(params[:id]).organization_id)
      end

      pipedrive_update_organization

    end

    def update
      @organization = Organization.find(params[:id])
      set_whitelist_update
      if @organization.update(@whitelistupdate)
        flash[:notice] = "Your Organization has been updated"
        redirect_to  compagny_account_organizations_path(params[:compagny_id].to_i)
        organization_update_pipedrive
        traceflow
      else
        flash[:alert] = "Your Organization has not been updated? Please try again"
        render :edit
      end
    end

  private
    def  pipedrive_authenticate
      #Authentificate, move this method for protect Api Token

        Pipedrive.authenticate(Compagny.find(params['compagny_id']).token)

    end

    def pipedrive_add_new_organization
      #Add New Orgazinations from PipeDrive To Organization Model
      @organizations = Organization.all
      @new = @organizations.count

      @orgapipes = Pipedrive::Organization.all(nil, options={:query=>{:start=>@new}}, true)
      @orgapipes.each do |orgapipe|
        if Organization.where(:pipe_organization_id=> orgapipe.id) == []

            Organization.create(pipe_organization_id: orgapipe.id, name: orgapipe.name, update_time: orgapipe.update_time )
        end
      end
    end

    def pipedrive_update_organization
      #Update one Orgazination from PipeDrive To Organization Model, call by edit action

      @check = Pipedrive::Organization.find(Organization.where(:id=>params[:id]).first.pipe_organization_id)

      if @check.update_time != Organization.find(params[:id]).update_time
        @gap = { :id=> @check.id, :name=> @check.name, :update_time=> @check.update_time, :active_flag=> @check.active_flag }
       # Organization.find(params[:id]).update(@gap)
      (Organization.where(:pipe_organization_id => params[:id]).first).update(@gap)

      edit
      end
    end

    def pipedrive_update_organizations
      #Update Orgazinations from PipeDrive To Organization Model, Job schedule,  not use with call action user time is so long!
      #Step 1 => check all Organization & Gap select update_time
      @organizations = Organization.all
      @orgapipes = Pipedrive::Organization.all(nil, options={:query=>{:start=>0}}, true)
      @gaps = { :id=> nil, :name=> nil, :update_time=> nil }
      @lists = []

      @orgapipes.each do |orgapipe|
        if orgapipe.update_time != Organization.where(:pipe_organization_id=>orgapipe.id).first.update_time
        @lists <<  @gaps.merge({:id =>orgapipe.id, :name => orgapipe.name, :update_time=> orgapipe.update_time, :active_flag=> orgapipe.active_flag})
        end
      end

      #Step 2 => check if Delete & Fusion from PipeDrive end update active_flag to Oraganization. 3734 1358
      if @organizations.count >  @orgapipes.count

        @organizations.each do |organization|
          @id = organization.pipe_organization_id
          if @orgapipes.select{ |oragnization, id| oragnization.id == @id} == []
            @check = Organization.find(organization.id)
            @check.update(active_flag: false)
          end
        end
      end

      #Step 3 => Update Organization whith lists
      @lists.each do |list|
        (Organization.where(:pipe_organization_id => list[:id]).first).update(list)
      end
    end


    def organization_update_pipedrive
      #Update Orgazinations from Organization To PipeDrive Model, call by edit action
      @active = params[:organization][:active_flag]
      @pipe_organization_id = Organization.find(params[:id]).pipe_organization_id
      @params = {:id=> @pipe_organization_id, :name => params[:organization][:name], :active_flag=> params[:organization][:active_flag]}
      Pipedrive::Organization.update(@params)

    end

    def set_whitelist_update
      @whitelistupdate = params.require(:organization).permit(:name, :active_flag)
    end

    def traceflow
    # Is it data for tracking action user and date for create & update => Move this method to lib for general tracking or find a gem
      @what = @_action_name
      @how = @current_user.id
      if @organization.updated_at == @organization.created_at
        @when = @organization.created_at
      else
        @when = @organization.updated_at
      end
    end
# its a good call for print person of compagny, is it  necessary to create a  persons model ? Yes for performance
# Pipedrive::Organization.find(params[:id]).persons
  end
end
