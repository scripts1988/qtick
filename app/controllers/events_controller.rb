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
end
