class EventsController < ApplicationController
  def index
    @events = Event.upcoming
  end

  def show
    @event = Event.find(params[:id])
  end

  def search
    @events_matches = Event.all
    if params[:term]
      @events_matches = Event.search(params[:term])
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event created success' }
        format.json { render :edit, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :extended_html_description, :venue_id, :category_id, :starts_at, :ends_at) 
  end
end
