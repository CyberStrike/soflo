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

  it 'can set a future date' do
    event_defaults
    # select_date_and_time(event.start, from: 'event_start')
    # select_date_and_time(event.finish, from: 'event_finish')
    select_time(event.start, from: 'event_start')
    select_date(event.start, from: 'event_start')
    click_on 'Save'
    expect(page).to have_content event.start.strftime('%a, %b %d, %Y, %I:%M %P')
  end

  it 'can not set a a past date' do
    fill_in 'event_title', with: event.title
    fill_in 'event_description', with: event.description
    # select_date_and_time(DateTime.now - 10.days, from: 'event_start')
    # select_date_and_time(event.finish, from: 'event_finish')
    select_time(event.start, from: 'event_start')
    select_date(Date.current - 10.days, from: 'event_start')
    click_on 'Save'
    expect(page).to have_content 'No Time Traveling Allowed'
  end

  it 'it can create a repeating event' do
    skip
  end

  it 'it can create a daily repeating event' do
    skip
  end

  it 'it can create a weekly repeating event' do
    skip
  end

  it 'it can create a monthly repeating event' do
    skip
  end

  it 'a user must be logged in to create an event' do
    skip
  end

  it 'belongs to user' do
    skip
  end

end
