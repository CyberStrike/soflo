require 'rails_helper'

RSpec.describe "events/show", :type => :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :title => "Title",
      :location => "Location",
      :ticketurl => "Ticketurl"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Ticketurl/)
  end
end
