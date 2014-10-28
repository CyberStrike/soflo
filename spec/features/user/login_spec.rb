require 'rails_helper'

context 'When a user logs in', :type => :feature do

  let!(:user){create(:user)}

  before :each do
    visit '/'
    click_on 'Register'
    click_on 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'
  end

  it 'it is successful' do
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'the profile link is visible' do
    expect(page).to have_content user.email
  end

  it 'they do not see register' do
    expect(page).to_not have_link 'Register'
  end

  it 'they can logout ' do
    click_on 'Log Out'
    expect(page).to have_content 'Signed out successfully.'
  end

end