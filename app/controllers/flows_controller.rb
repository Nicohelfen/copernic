class FlowsController < ApplicationController

  def show
    @flow = Flow.find(params[:id])
  end

  def index
    @flows = Flow.all
  end

  def edit

      @flow = Flow.find(params[:id])

  end



  def new
    preference_user
    @counterselector = Counter.where(:name=> "Flow",:compagny_id=> @active_preference).first
    @levels = Level.where(:compagny_id=> @counterselector.compagny_id)
    @flow = Flow.new(code: Counter.find(counter_id = @counterselector).actual +=1, compagny_id: @active_preference.id )
  end

  def create
    preference_user
    @counterselector = Counter.where(:name=> "Flow",:compagny_id=> @active_preference).first
    set_whitelist
    @flow = Flow.new(@whitelist)
    @flow.save

    if @flow.valid?
      update_counter
      flash[:notice] = "Flow successful !"
      traceflow
      redirect_to flow_path(@flow)
    else
      flash[:alert] = "Failed to New Flow !"
      render "new"
    end
  end

private

    def set_whitelist
      @whitelist = params.require(:flow).permit(:name, :description, :deliverable, :date_sale )
      @whitelist[:code] = (Counter.find(counter_id = @counterselector).actual +=1)
      @whitelist[:counter_id] = @counterselector.id
      @whitelist[:compagny_id] = @active_preference.id
      @whitelist[:level_id] = params[:flow][:level]
    end

    def update_counter
      counter = Counter.find(@flow.counter_id)
      counter.update(actual: @flow.code)
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

  def traceflow
  # Is it data for tracking action user and date for create & update flow
    @what = @_action_name
    @how = @current_user.id
    if @flow.updated_at == @flow.created_at
      @when = @flow.created_at
    else
      @when = flow.updated_at
    end
  end

end
