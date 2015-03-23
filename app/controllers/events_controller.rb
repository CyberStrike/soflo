class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :calendar]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_date, only: [:index, :calendar]

  # GET /events
  # GET /events.json
  def index
    # @events = Event.all
    @events_by_week = Event.where(:start => @date.beginning_of_week..@date.end_of_week ).order(:start).group_by(&:startdate) || Event.this_week.order(:start).group_by(&:startdate)

    ## display variables

    @display_month = @date.year < Date.current.year ? @date.strftime("%B %Y") : @date.strftime("%B")

  end

  def calendar
    @events = Event.all
    @events_by_date = @events.group_by &:startdate
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @location = @event.build_location_event.build_location
  end

  # GET /events/1/edit
  def edit
    @location = @event.location || @event.build_location_event.build_location
    if @event.user != current_user
      redirect_to events_url, notice: 'Invalid Permissions.'
    end
  end

  # POST /events
  # POST /events.json
  def create

    @event = Event.new(event_params.except(:location))
    @event.user = current_user
    # Since we aren't using finish in the view at the moment set it to all day.
    @event.finish = @event.start + 23.hours
    @event.build_location_event.location = Location.find_or_initialize_by(location_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update

    @event.location_event.location = Location.find_or_initialize_by(location_params)

    respond_to do |format|
      if @event.user == current_user && @event.update(event_params.except(:location))
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    respond_to do |format|
      if @event.user == current_user && @event.destroy
        format.html { redirect_to events_url, notice: @event.title + ' was deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to events_url, notice: 'Invalid Permissions.' }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def set_date
      @date = params[:date] ? Date.parse(params[:date]): Date.current
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :start, :finish, :ticketurl, :description, :location => [:name, :streetnumber, :street, :city, :state, :zip, :country])
    end

    def location_params
      event_params[:location]
    end

end
