module Account
  class FlowsController < ApplicationController

    before_action :find_compagny, only: [ :new, :create, :update ]
    before_action :select_level

    def show
      @flow = Flow.find(params[:id])
    end

    def index
      @flows = Flow.where(:compagny_id=> params[:compagny_id]).sort

    end

    def edit
      @flow = Flow.find(params[:id])
    end

    def update
      @flow = Flow.find(params[:id])
      set_whitelist_update

      if @flow.update(@whitelistupdate)
        flash[:notice] = "Your Flow has been updated"
        redirect_to  compagny_account_flows_path(params[:compagny_id].to_i)
        traceflow
      else
        flash[:alert] = "Your Flow has not been updated? Please try again"
        render :edit
      end
    end

    def new
      # preference_user
      select_level
      @flow = Flow.new(code: Counter.find(counter_id = @counterselector).actual +=1, compagny_id: params[:compagny_id].to_i, level_id:  @levels.first.id)

    end

    def create
      preference_user
      @counterselector = Counter.where(:name=> "Flow",:compagny_id=> params[:compagny_id].to_i).first
      set_whitelist
      @flow = Flow.new(@whitelist)
      @flow.save

      if @flow.valid?
        update_counter
        flash[:notice] = "Flow successful !"
        traceflow
        redirect_to compagny_account_flow_path( params[:compagny_id].to_i, @flow)
      else
        flash[:alert] = "Failed to New Flow !"
        render "new"
      end
    end

  private

    def set_whitelist
      @whitelist = params.require(:flow).permit(:name, :description, :deliverable, :date_sale)
      @whitelist[:code] = (Counter.find(counter_id = @counterselector).actual +=1)
      @whitelist[:counter_id] = @counterselector.id
      @whitelist[:compagny_id] = params[:compagny_id].to_i
      @whitelist[:level_id] = params[:flow][:level]
    end

    def set_whitelist_update
      @whitelistupdate = params.require(:flow).permit(:name, :description, :deliverable, :date_sale)

      @whitelistupdate[:level_id] = params[:flow][:level].to_i


    end


    def update_counter
      counter = Counter.find(@flow.counter_id)
      counter.update(actual: @flow.code)
    end

    def find_compagny
      if current_user
        @compagny = Compagny.find(params[:compagny_id])
      end
    end

    def preference_user
    #Change Compagny context for user
      if current_user
        @preference_user = User.find(current_user.id).compagnies

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
      @active_preference = User.find(current_user.id).compagnies
    end

    def select_level
      @counterselector = Counter.where(:name=> "Flow",:compagny_id=> params[:compagny_id].to_i).first
      @levels = Level.where(:compagny_id=> params[:compagny_id]).sort_by {|s| s.sequence}
    end

    def traceflow
    # Is it data for tracking action user and date for create & update flow
      @what = @_action_name
      @how = @current_user.id
      if @flow.updated_at == @flow.created_at
        @when = @flow.created_at
      else
        @when = @flow.updated_at
      end
    end
  end


end
