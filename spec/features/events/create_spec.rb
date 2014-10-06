require 'rails_helper'

context 'When creating an Event', :type => :feature do

  let!(:event){create(:event)}

  before :each do
    visit '/events'
    click_on 'New Event'
  end

  it 'it saves successfully' do
    expect(page).to have_content 'New event'
    fill_in 'Title', with: event.title
    fill_in 'Description', with: event.description
    select_date_and_time(event.start, from: 'event_start')
    select_date_and_time(event.finish, from: 'event_finish')
    click_on 'Save'
    expect(page).to have_content event.description
  end
  it 'it displays error without title of more than two characters' do
    fill_in 'Title', with: 'a'
    click_on 'Save'
    expect(page).to have_content 'is too short (minimum is 2 characters)'
  end

  it 'it displays error without description of more than 2 characters' do
    fill_in 'Description', with: 'a'
    click_on 'Save'
    expect(page).to have_content 'is too short (minimum is 2 characters)'
  end

  it 'belongs to user' do
    skip
  end

  it 'can set a future date' do
    skip
  end

end