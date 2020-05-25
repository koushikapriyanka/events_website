class UserEventsController < ApplicationController
  before_action :set_user_event, only: [:show, :cancel]

  def index
    if params[:event_id]
      @event = Event.find_by_id(params[:event_id])
      @event_users = UserEvent.includes(:user).where(event_id: params[:event_id], status: :attended)
      @user_event = UserEvent.where(event_id: params[:event_id], user_id: current_user.id).last if current_user
    end
  end

  def show
    render body: nil unless @user_event
  end

  def new
    @user_event = UserEvent.new
    @event = Event.find_by_id(params[:event_id])
  end

  def create
    @user_event = current_user.user_events.create(user_event_params)
    respond_to do |format|
      if @user_event.save
        format.html { redirect_to event_user_event_path(event_id: @user_event.event_id, id: @user_event.id), notice: 'You are successfully registered for event.' }
        format.json { render :show, status: :created, location: @user_event }
      else
        format.html { redirect_to event_user_events_path(event_id: @user_event.event_id), notice: @user_event.errors.messages[:error].join(',') }
        format.json { render json: @user_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    @user_event.unattend
    respond_to do |format|
      if @user_event.save
        format.html { redirect_to event_user_event_path(event_id: @user_event.event_id, id: @user_event.id), notice: 'You are successfully unregistered for event.' }
        format.json { head :no_content }
      else
        format.html { redirect_to event_user_events_path(event_id: @user_event.event_id), notice: @user_event.errors.messages[:error].join(',') }
        format.json { render json: @user_event.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user_event
    @user_event = current_user.user_events.find_by_id(params[:id])
  end

  def user_event_params
    params.permit(:event_id, :ticket_fee)
  end
end
