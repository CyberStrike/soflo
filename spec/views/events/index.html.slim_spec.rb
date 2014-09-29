require 'rails_helper'

RSpec.describe "events/index", :type => :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :title => "Title",
        :location => "Location",
        :ticketurl => "Ticketurl"
      ),
      Event.create!(
        :title => "Title",
        :location => "Location",
        :ticketurl => "Ticketurl"
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Ticketurl".to_s, :count => 2
  end
end
