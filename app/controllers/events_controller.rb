class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_date, only: [:index, :calendar]

  # GET /events
  # GET /events.json
  def index
    # @events = Event.all
    @events_by_week = Event.where(:start => @date.beginning_of_week..@date.end_of_week ).order(:start).group_by(&:startdate) || Event.this_week.order(:start).group_by(&:startdate)
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
  end

  # GET /events/1/edit
  def edit
      if @event.user != current_user
        redirect_to events_url, notice: 'Invalid Permissions.'
      end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params.merge(user: current_user))

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
    respond_to do |format|
      if @event.user == current_user && @event.update(event_params)
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
      params.require(:event).permit(:title, :start, :finish, :location, :ticketurl, :description)
    end

end
