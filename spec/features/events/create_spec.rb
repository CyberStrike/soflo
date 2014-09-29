require 'rails_helper'

context 'When creating an Event' do

  # let!(:event){Event.create title: 'Ruby Meetup', desc: 'Learn you some Ruby'}

  before :each do
    visit '/events'
  end

  it 'it saves successfully' do
    click_on 'New Event'
    expect(page).to have_content 'New event'
    fill_in 'Title', with: 'Ruby Meetup'
    click_on 'Save'
    expect(page).to have_content 'Ruby Meetup'
  end

  it 'it displays error without title' do
    skip
  end
  it 'it displays error without start date' do
    skip
  end

  it 'it displays error without description of more than 2 characters' do
    skip
  end

  it 'belongs to user' do
    skip
  end
  it 'can set a future date' do
    skip
  end

end