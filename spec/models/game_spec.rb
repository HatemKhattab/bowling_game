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

  it " Add ball3 in the tenth frame if it was strike or spare" do
    (0..9).each do |num|
      @game.play(10,nil)
    end
    expect(@game.frames[9][:ball_3]).to be_between(0, 10)
  end

  describe 'Testing with scenario 1' do
    # game table at http://www.alltombowling.nu/skola_rakna.php
    before {
      @game = Game.new
      frames = [[6, 2], [8, 2], [10, nil], [9, 0], [6, 4], [8, 1], [9, 1], [10, nil], [10, nil], [8, 2]]
      frames.each do |b1, b2|
        @game.play(b1, b2)
      end
    }

    it 'calculate the right score' do
      frame_1 = @game.frames[0]
      frame_2 = @game.frames[1]
      frame_3 = @game.frames[2]
      frame_4 = @game.frames[3]
      frame_5 = @game.frames[4]
      frame_6 = @game.frames[5]
      frame_7 = @game.frames[6]
      frame_8 = @game.frames[7]
      frame_9 = @game.frames[8]
      frame_10 = @game.frames[9]

      expect(frame_1[:score]).to eq(8)
      expect(frame_2[:score]).to eq(28)
      expect(frame_3[:score]).to eq(47)
      expect(frame_4[:score]).to eq(56)
      expect(frame_5[:score]).to eq(74)
      expect(frame_6[:score]).to eq(83)
      expect(frame_7[:score]).to eq(103)
      expect(frame_8[:score]).to eq(131)
      expect(frame_9[:score]).to eq(151)
      expect(frame_10[:score]).to eq(161)
    end
  end

  describe 'Testing with scenario 1' do

    before {
      @game = Game.new
      frames = [[10, nil], [10, nil], [10, nil], [5, 1]]
      frames.each do |b1, b2|
        @game.play(b1, b2)
      end
    }

    it 'calculate the right score' do
      frame_1 = @game.frames[0]
      frame_2 = @game.frames[1]
      frame_3 = @game.frames[2]
      frame_4 = @game.frames[3]

      expect(frame_1[:score]).to eq(30)
      expect(frame_2[:score]).to eq(55)
      expect(frame_3[:score]).to eq(71)
      expect(frame_4[:score]).to eq(77)
    end
  end
end