class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :calendar]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_date, only: [:index, :calendar]
  before_action :set_colors, only: [:index, :show]

  def index
    # Lets just show the next 20 events and worry about proper navigation sorting another time.
    @events_by_week = Event.where('start > ?', @date).order(:start).limit(params[:limit]).group_by(&:startdate)

    # @events_by_week = Event.where(:start => @date.yesterday..@date.at_end_of_week + 1.day).order(:start).group_by(&:startdate) || Event.this_week.order(:start).group_by(&:startdate)

    ## display variables

    @display_month = @date.year < Date.current.year ? @date.strftime("%B %Y") : @date.strftime("%B")

  end

  def calendar
    @events = Event.all
    @events_by_date = @events.group_by &:startdate
  end

  def show
  end

  def new
    @event = Event.new(
        start:  (Time.now + 1.hour).beginning_of_hour,
        finish: (Time.now + 2.hour).beginning_of_hour)
    @location = @event.build_location_event.build_location

  end

  def edit
    @location = @event.location || @event.build_location_event.build_location

    if @event.user != current_user
      redirect_to events_url, notice: 'Invalid Permissions.'
    end
  end

  def create

    @event = Event.new(event_params.except(:location))
    @event.user = current_user
    # Since we aren't using finish in the view at the moment set it to all day.
    # @event.finish = @event.start.end_of_day
    @location = Location.find_or_initialize_by(location_params)
    @event.build_location_event.location = @location

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

  def update
    @location = @event.location || @event.build_location_event.build_location

    @event.location_event.location = Location.find_or_initialize_by(location_params)
    @event.location_event.location.update(location_params)

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
      @date = params[:date] ? Date.parse(params[:date]) : Date.current
    end

    def set_colors
      @colors = %w(#f44336 #E91E63 #9C27B0 #673AB7
                 #3F51B5 #2196F3 #03A9F4 #00BCD4
                 #009688 #4CAF50 #8BC34A #CDDC39
                 #FFEB3B #FFC107 #FF9800 #FF5722)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :start, :finish, :ticketurl, :description, :location => [:name, :streetnumber, :street, :city, :state, :zip, :country, :unit, :long_address])
    end

    def location_params
      event_params[:location]
    end

end
