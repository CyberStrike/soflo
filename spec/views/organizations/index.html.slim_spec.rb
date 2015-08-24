require 'rails_helper'

RSpec.describe "organizations/index", type: :view do
  before(:each) do
    assign(:organizations, [
      Organization.create!(),
      Organization.create!()
    ])
  end

  it "renders a list of organizations" do
    render
  end
end
