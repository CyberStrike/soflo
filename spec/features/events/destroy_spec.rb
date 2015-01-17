require 'rails_helper'

context 'When deleting an Event', :type => :feature do

  let!(:mario){create(:user)}
  let!(:luigi){create(:user)} # second user for testing
  let!(:mario_event){create(:event, user: mario)}
  let!(:luigi_event){create(:event, user: luigi)}
  let!(:event_mock){build(:event)}

  before :each do |e|
    unless e.metadata[:skip_before]
      login_as mario
      visit event_path(mario_event)
      click_on 'Edit'
    end
  end

  it 'a user must be logged in to destroy an event', skip_before: true do
    visit edit_event_path(mario_event)
    expect(page).to have_content 'Log in'
  end

  it 'a user can only destroy their own events' do
    visit edit_event_path(luigi_event)
    expect(page).to have_content 'Invalid Permissions'
  end

  it 'it deletes successfully' do
    visit edit_event_path(mario_event)
    click_on 'Delete'
    expect(page).to have_content mario_event.title + ' was deleted.'
  end

end