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

	def edit 
		@event = Event.find_by_id(params[:id])
    @ticket_types = TicketType.where('event_id = ?', @event.id)
	end

	def publish
		event = Event.find_by_id(params[:event_id])
    ticket_types = TicketType.where('event_id = ?', event.id)
    if ticket_types.empty? == false 
		  event.publish_status = true
		  event.save!
    end
		redirect_to root_path
	end

	def create
		@event = Event.new(event_params)
		@event.user_id = current_user.id
		respond_to do |format|
			if @event.save
				format.html { render :edit, :id => @event.id, notice: 'Event created success' }
				format.json { render :edit, status: :created, location: @event }
			else
				format.html { render :new }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	def modify
		@event = Event.find_by_id(params[:event_id])
	end

	def update
		@event = Event.find_by_id(params[:id])
		respond_to do |format|
			if @event.update(event_params)
				format.html { render :edit, :id => @event.id, notice: 'Event updated success' }
				format.json { render :show, status: :ok, location: @food_item }
			else
				format.html { render :new }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	def mine
		@events = Event.where("user_id = ?", current_user.id)
	end

	private
	def event_params
		params.require(:event).permit(:name, :extended_html_description, :venue_id, :category_id, :starts_at, :ends_at) 
	end
end
