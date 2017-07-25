require 'rails_helper'
RSpec.describe Game, type: :model do

  before {
    @game = Game.new
  }

  it 'can create a new game' do
    expect(@game).not_to be_nil
  end

  it 'new game contains frames as empty array ' do
    expect(@game).to have_attributes(frames: [])
  end

  it 'play functoin add new frame to frames array' do
    @game.play
    expect(@game.frames.size).to eq(1)
  end

end