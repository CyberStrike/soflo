require 'rails_helper'

context 'When viewing an Event', :type => :feature do

  let!(:user){ create(:user) }
  let!(:event){ create(:event, user: user) }

  before :each do
    login_as user
    visit '/'
    click_on 'Add Event'
  end

  describe 'crawlers' do
    it 'can see Facebook Open Graph Tags'
    it 'can see Twitter Tags'
  end

end