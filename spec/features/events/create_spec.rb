require 'rails_helper'

context 'When creating an Event' do

  let!(:event){Event.new title: 'Ruby Meetup', description: 'Learn you some Ruby'}

  before :each do
    visit '/events'
  end

  it 'it saves successfully' do
    click_on 'New Event'
    expect(page).to have_content 'New event'
    fill_in 'Title', with: event.title
    fill_in 'Description', with: event.desc
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
    click_on 'New Event'
    fill_in 'Desc', with: 'a'
    click_on 'Save'
    expect(page).to have_content 'is too short (minimum is 2 characters)'
  end

  it 'belongs to user' do
    skip
  end
  it 'can set a future date' do
    skip
  end




  # it 'displays an error with no content' do
  #   click_on 'New Todo'
  #   fill_in 'Content', with: ''
  #   click_on 'Save'
  #   expect(page).to have_content 'Content can\'t be blank'
  # end

  # it 'displays an error when the Todo List has no title' do
  #   create_todo_list title:''
  #   expect(page).to have_content 'error'
  # end
  #
  # it 'displays an error when the Todo List has a title less than two character' do
  #   create_todo_list title: 'a'
  #   expect(page).to have_content 'error'
  # end

end