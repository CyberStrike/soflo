require 'rails_helper'

RSpec.describe "events/index", :type => :view do
  before(:each) do
    @event = create(:event)
    @events = assign(:events, [
      @event, @event
    ])
    assign(:date, Date.strptime(FFaker::Time.date))
    assign(:events_by_week, @events.group_by(&:startdate))
    assign(:colors, [])
  end

  it "renders a list of events" do
    render
    assert_select ".event-card>.title", :text => @event.title, :count => 2
    # assert_select "tr>td", :text => @event.location, :count => 2
    # assert_select "tr>td", :text => @event.ticketurl, :count => 2
  end
end
