class TicketsController < ApplicationController
  def purchase 
    @event = Event.find(params[:event_id])
  end

  def new
    @event = Event.find(params[:event_id])
    @ticket_type = TicketType.new 
    @ticket_type.event_id = params[:event_id]
  end

  def create
    @ticket_type = TicketType.new(tickets_params)
    @ticket_type.event_id = params[:event_id]
    @event = Event.find(params[:event_id])
    respond_to do |format|
      if @ticket_type.save
        format.html { redirect_to edit_event_path([@event.id]), notice: 'Tickets is added' }
        format.json { render :edit, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @ticket_type.errors, status: :unprocessable_entity }
      end
    end

  end

  private
  def tickets_params
    params.require(:ticket).permit(:name, :max_quantity, :price)
  end
end
