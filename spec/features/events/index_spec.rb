require 'rails_helper'

context 'Listing an Event', :type => :feature do

  let!(:mario){create(:user)}
  let!(:mushroom_kingdom) {create(:location)}
  let!(:mario_party){create(:event, user: mario, location: mushroom_kingdom)}

  before :each do |e|
    unless e.metadata[:skip_before]
      visit '/'
    end
  end

  after :each do
    Warden.test_reset!
  end

  it 'it has correct information' do
    ## Check Title
    expect(page).to have_content mario_party.title
    ## Check Time
    expect(page).to have_content (mario_party.start.strftime('%I:%M %p') + ' - ' + mario_party.finish.strftime('%I:%M %p'))
  end

end