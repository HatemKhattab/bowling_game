require 'rails_helper'
describe 'Bowling features', :type => :feature do
  before {
    visit '/'
  }

  it 'index page contains two buttons' do
    expect(page).to have_button('Player 1')
    expect(page).to have_button('Player 2')
  end

end

