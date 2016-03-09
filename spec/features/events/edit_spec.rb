require 'rails_helper'

context 'When editing an Event', :type => :feature do

  let!(:mario){create(:user)}
  let!(:luigi){create(:user)} # second user for testing
  let!(:mushroom_kingdom) {create(:location)}
  let!(:mario_party){create(:event, user: mario, location: mushroom_kingdom)}
  let!(:luigi_party){create(:event, user: luigi, location: mushroom_kingdom)}
  let!(:event_mock){build(:event)}

  before :each do |e|
    unless e.metadata[:skip_before]
      login_as mario
      visit event_path(mario_party)
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
    select_time(event_mock.finish, from: 'event_finish')
    select_date(event_mock.start, from: 'event_start')

    click_on 'Save'

    ## Check Title
    expect(page).to have_content event_mock.title

    ## Check Time
    expect(page).to have_content (event_mock.start.strftime('%I:%M %p') + ' - ' + event_mock.finish.strftime('%I:%M %p'))

    ## Check Description
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
    visit event_path(mario_party)
    expect(page).not_to have_content 'Edit'
  end

  it 'a user can only edit their own events' do
    visit event_path(luigi_party)
    expect(page).not_to have_content 'Edit'
  end

end