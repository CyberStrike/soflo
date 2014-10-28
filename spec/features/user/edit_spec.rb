require 'rails_helper'
Warden.test_mode!

context 'When a user edits ', :type => :feature do

  let!(:user){create(:user)}

  before :each do
    visit '/'
    click_on 'Register'
    click_on 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'it saves successfully' do
    click_on user.email
  end
end