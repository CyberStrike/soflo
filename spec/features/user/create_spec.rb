require 'rails_helper'

context 'When a user signs up', :type => :feature do

  let!(:user){build(:user)}

  before :each do
    visit '/'
    click_on 'Sign Up'
  end

  it 'it saves successfully' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

end