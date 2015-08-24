require 'rails_helper'

RSpec.describe "events/show", :type => :view do
  before(:each) do
    @event = assign(:event, create(:event))
    assign(:colors, [])
    allow(view).to receive(:current_user).and_return(nil)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{@event.title}/)
    expect(rendered).to match(/#{@event.location}/)
    expect(rendered).to match(/#{@event.ticketurl}/)
  end
end
