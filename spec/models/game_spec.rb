require 'rails_helper'
RSpec.describe Game, type: :model do

  it 'can create a new game' do
    @game = Game.new
    expect(@game).not_to be_nil
  end

  it 'new game contains frames as empty array ' do
    @game = Game.new
    expect(@game).to have_attributes(frames: [])
  end

end