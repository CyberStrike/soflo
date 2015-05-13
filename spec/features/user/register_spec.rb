require 'rails_helper'
Warden.test_mode!

context 'When a user signs up', :type => :feature do

  let!(:user){build(:user)}

  badpass = FFaker::Internet.password[0..rand(7)]

  before :each do
    visit '/'
    click_on 'Register'
  end

  it 'it is successful' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  it 'they must have an email' do
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'
    expect(page).to have_content "Email can't be blank"
  end

  it 'the password must have 8 characters' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: badpass
    fill_in 'Password confirmation', with: badpass
    click_on 'Sign up'
    expect(page).to have_content 'Password is too short (minimum is 8 characters)'
  end

  it 'they must confirm password' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: badpass
    click_on 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match"
  end

end