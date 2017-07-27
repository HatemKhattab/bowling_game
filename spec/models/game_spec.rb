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

  it 'play add frame with two balls within 0 t0 10' do
    @game.play
    frame = @game.frames.last
    expect(frame[:ball_1]).to be_between(0, 10)
    expect(frame[:ball_2]).to be_between(0, 10)
  end

  it 'play can add frame with parameters' do
    @game.play(2, 6)
    frame = @game.frames.last
    expect(frame[:ball_1]).to eq(2)
    expect(frame[:ball_2]).to eq(6)
  end

  it 'ball2 is nil if ball1=10' do
    @game.play(10, 0)
    frame = @game.frames.last
    expect(frame[:ball_2]).to be_nil
  end

  describe 'Testing with existing scenario' do
    # game table at http://www.alltombowling.nu/skola_rakna.php
    @game = Game.new
    frames = [[6, 2], [8, 2], [10, nil], [9, 0], [6, 4], [8, 1], [9, 1], [10, nil], [10, nil]]

    frames.each do |b1, b2|
    @game.play(b1, b2)
    end

  end
end