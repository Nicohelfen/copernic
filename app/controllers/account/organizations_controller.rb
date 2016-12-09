module Account
require 'pipedrive-ruby'

  class OrganizationsController < ApplicationController

    before_action :pipedrive_authenticate

    def index
      # Check if exsiting news Organizations on PipeDrive and create

      # pipedrive_add_new_organization

      # Display & Sort Organizations for Active Compagny
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
      #Add New Orgazinations from PipeDrive To Organization Model,  only use with syncho_organizations_date
      @organizations =  Organization.where(:compagny_id=> params[:compagny_id])

      #Use @new only for duration optimisation into options={:query=>{:start=>@new}.
      @new = @organizations.count
      @orgapipes = Pipedrive::Organization.all(nil, options={:query=>{:start=>@new}}, true)
      @orgapipes.each do |orgapipe|
        if Organization.where(:compagny_id=> params[:compagny_id].to_i).where(:pipe_organization_id=> orgapipe.id) == []
          Organization.create(:compagny_id=> params[:compagny_id].to_i, pipe_organization_id: orgapipe.id, name: orgapipe.name, update_time: orgapipe.update_time )
        end
      end
    end

    def pipedrive_update_organization
      #Update one Orgazination from PipeDrive To Organization Model, call by edit & Show actions
      @check = Pipedrive::Organization.find(Organization.where(:id=>params[:id]).first.pipe_organization_id)

      if @check.update_time != Organization.find(params[:id]).update_time
        @gap = { :id=> @check.id, :name=> @check.name, :update_time=> @check.update_time, :active_flag=> @check.active_flag }
       # Organization.find(params[:id]).update(@gap)
      (Organization.where(:pipe_organization_id => params[:id]).first).update(@gap)

      edit
      end
    end


    def pipedrive_update_organizations
      #Update Organizations from PipeDrive To Organization Model, only use with syncho_organizations_date
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
        @list = {:name => list[:name], :active_flag => list[:active_flag]}
        (Organization.where(:pipe_organization_id => list[:id]).first).update(@list)
      end
    end


    def organization_update_pipedrive
      #Update Organization from Organization To PipeDrive Model, call by edit action
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

    def synchro_organizations_date
      # Add & Update Organizations from PipeDrive To Organization Model, Job schedule,  not use with call action user time is so long!
      # For perferct integration With PipeDrive to Corpornic, developp on API in copernic and Use Zapier (zapier.com) for Integration. API to API
      pipedrive_add_new_organization
      pipedrive_update_organizations
    end

# its a good call for print person of compagny, is it  necessary to create a  persons model ? Yes for performance
# Pipedrive::Organization.find(params[:id]).persons
  end
end

