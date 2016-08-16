class EventsController < ApplicationController
  def index
    @events = Event.all
    @upcoming_events = Event.upcoming
    @past_events = Event.past
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event successfully added!"
      redirect_to current_user
    else
      flash.now[:danger] = "Invalid event info."
      render 'new'
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :begin_date, :end_date, :details)
  end
end
