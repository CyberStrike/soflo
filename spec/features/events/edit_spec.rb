require 'rails_helper'

context 'When editing an Event', :type => :feature do

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

  after :each do
    Warden.test_reset!
  end

  it 'it saves successfully' do
    fill_in 'event_title', with: event_mock.title
    fill_in 'event_description', with: event_mock.description
    select_time(event_mock.start, from: 'event_start')
    select_date(event_mock.start, from: 'event_start')
    click_on 'Save'
    expect(page).to have_content event_mock.start.strftime('%a, %b %d, %Y, %I:%M %P')
    # expect(page).to have_content event_mock.finish.strftime('%a, %b %d, %Y, %I:%M %P')
    expect(page).to have_content event_mock.description
  end

  it 'it displays error without title of more than two characters' do
    fill_in 'event_title', with: 'a'
    click_on 'Save'
    expect(page).to have_content 'is too short (minimum is 2 characters)'
  end

  it 'it displays error without description of more than 2 characters' do
    fill_in 'event_description', with: 'a'
    click_on 'Save'
    expect(page).to have_content 'is too short (minimum is 2 characters)'
  end

  it 'a user must be logged in to edit an event', skip_before: true do
    visit event_path(mario_event)
    expect(page).not_to have_content 'Edit'
  end

  it 'a user can only edit their own events' do
    visit event_path(luigi_event)
    expect(page).not_to have_content 'Edit'
  end

end