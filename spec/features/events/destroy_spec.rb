require 'rails_helper'

context 'When deleting an Event', :type => :feature do

  let!(:user){create(:user)}
  let!(:event){create(:event, user: user)}

  before :each do
    login_as user
    visit '/events'
  end

  it 'a user must be logged in to destroy an event' do
    skip
  end

  it 'a user can only destroy their own events' do
    skip
  end

  it 'it deletes successfully' do
    skip
    # event_defaults
    # select_date_and_time(event.start, from: 'event_start')
    # select_date_and_time(event.finish, from: 'event_finish')
    # click_on 'Save'
    # expect(page).to have_content event.description
  end

end