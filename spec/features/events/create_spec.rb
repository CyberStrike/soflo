require 'rails_helper'

context 'When creating an Event', :type => :feature do

  let!(:user){  create(:user)}
  let!(:event){ build(:event, user: user)}

  before :each do
    login_as user
    visit '/'
    click_on 'Add Event'
  end

  def event_defaults
    fill_in 'event_title', with: event.title
    fill_in 'event_description', with: event.description
  end

  it 'it saves successfully' do
    event_defaults
    # select_date_and_time(event.start, from: 'event_start')
    # select_date_and_time(event.finish, from: 'event_finish')
    select_time(event.start, from: 'event_start')
    select_date(event.start, from: 'event_start')
    click_on 'Save'
    expect(page).to have_content event.description
  end

  it 'it displays an error without a title of more than two characters' do
    fill_in 'event_title', with: 'a'
    click_on 'Save'
    expect(page).to have_content 'is too short (minimum is 2 characters)'
  end

  it 'it displays an error without a description of more than 2 characters' do
    fill_in 'event_description', with: 'a'
    click_on 'Save'
    expect(page).to have_content 'is too short (minimum is 2 characters)'
  end

  it 'can set a future date' do
    event_defaults
    # select_date_and_time(event.start, from: 'event_start')
    # select_date_and_time
    select_date(event.start, from: 'event_start')
    select_time(event.start, from: 'event_start')
    select_time(event.finish, from: 'event_finish')
    click_on 'Save'
    expect(page).to have_content event.start.strftime('%a, %b %d, %Y')
    expect(page).to have_content event.start.strftime('%I:%M %p') + ' - ' + event.finish.strftime('%I:%M %p')
  end

  it 'can not set a past start date' do
    fill_in 'event_title', with: event.title
    fill_in 'event_description', with: event.description
    # select_date_and_time(DateTime.now - 10.days, from: 'event_start')
    # select_date_and_time(event.finish, from: 'event_finish')
    select_time(event.start, from: 'event_start')
    select_date(Date.current - 10.days, from: 'event_start')
    click_on 'Save'
    expect(page).to have_content 'No Time Traveling Allowed'
  end

  it 'can not create an event that finishes before the start' do
    fill_in 'event_title', with: event.title
    fill_in 'event_description', with: event.description
    select_time(event.start, from: 'event_start')
    select_time(event.start - 1.hour, from: 'event_finish')
    select_date(event.start, from: 'event_start')
    click_on 'Save'
    expect(page).to have_content 'An Event Cannot Finish Before It Has Started.'
  end

  it 'it can create a repeating event'

  it 'it can create a daily repeating event'

  it 'it can create a weekly repeating event'

  it 'it can create a monthly repeating event'

  it 'a user must be logged in to create an event'

  it 'it belongs to user'

end
