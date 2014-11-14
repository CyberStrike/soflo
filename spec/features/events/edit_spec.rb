require 'rails_helper'

context 'When editing an Event', :type => :feature do

  let!(:user){create(:user)}
  let!(:event){create(:event)}
  let!(:event_mock){build(:event)}

  before :each do |example|
    unless example.metadata[:skip_before]
      login_as user
      visit event_path(event)
      click_on 'Edit'
    end
  end

  after :each do
    Warden.test_reset!
  end

  it 'it saves successfully' do
    fill_in 'Title', with: event_mock.title
    fill_in 'Description', with: event_mock.description
    select_date_and_time(event_mock.start, from: 'event_start')
    select_date_and_time(event_mock.finish, from: 'event_finish')
    click_on 'Save'
    expect(page).to have_content event_mock.start
    expect(page).to have_content event_mock.finish
    expect(page).to have_content event_mock.description
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

  it 'a user must be logged in to edit an event', skip_before: true do
    visit event_path(event)
    expect(page).not_to have_content 'Edit'
  end

  it 'a user can only edit their own events' do
    skip
  end

  it 'a user must be logged in to destroy an event' do
    skip
  end

  it 'a user can only destroy their own events' do
    skip
  end



  it 'belongs to user' do
    skip
  end



end