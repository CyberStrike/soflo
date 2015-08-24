require 'rails_helper'

RSpec.describe "events/edit", :type => :view do
  before(:each) do
    @event = create(:event)
    @location = create(:location)
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_title[name=?]", "event[title]"

      assert_select "input#event_location[name=?]", ""

      assert_select "input#event_ticketurl[name=?]", "event[ticketurl]"
    end
  end
end
