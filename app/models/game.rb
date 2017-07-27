class Game < ActiveRecord::Base
  serialize :frames, Array
  PINS = 10

  def intialize
  end

  def play(b1 = nil, b2 = nil)
    #TODO: raise error if b1 or b2 > 10 or b1+b2>10
    #TODO: ensure max 10 frames
    #TODO: fix score calculation
    ball1 = b1.present? ? b1 : rand(0..PINS)
    ball2 = b2.present? ? b2 : rand(0..PINS - ball1)
    ball2 = nil if ball1==10
    frames << {ball_1: ball1, ball_2: ball2, score: 0 }
  end
end


#a = ("a" if foo) || ("b" if bar) || "c"
#if foo then 'a' elsif bar; then 'b' else 'c'
