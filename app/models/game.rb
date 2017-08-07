class Game < ActiveRecord::Base
  serialize :frames, Array
  PINS = 10

  def intialize
  end

  def play(b1 = nil, b2 = nil)
    #TODO: raise error if b1 or b2 > 10 or b1+b2>10
    #TODO: ensure max 10 frames game over
    #TODO: fix score calculation

    ball1 = b1.present? ? b1 : rand(0..PINS)
    ball2 = b2.present? ? b2 : rand(0..PINS - ball1)
    ball2 = nil if ball1==10
    sum = ball1 + ( ball2.present? ? ball2 : 0)
    strike_status = (ball1==10)
    spare_status = ((ball1 + (ball2.present? ? ball2 : 0) ==10) && ball1 != 10)
    ball3 = (frames.size==9 && (strike_status || spare_status) )? rand(0..10): nil
    frame = {ball_1: ball1, ball_2: ball2,ball_3: ball3, score: sum , strike: strike_status, spare: spare_status }
    frames << frame
    clac_score(current_index) if current_index > 0
  end

  def clac_score(frame_num)
    # => TODO: calculate next two hits if next is strike
    current_frame = frames[frame_num]
    prev_frame = frames[frame_num - 1]
    if prev_frame[:spare] || prev_frame[:strike]
      frames[frame_num - 1][:score]+= current_frame[:ball_1] + (prev_frame[:strike] && !current_frame[:strike] ? current_frame[:ball_2] : 0)
    end
    frames[frame_num][:score] += prev_frame[:score]

    #try code ..............................
    if current_index >=2
      p_prev_frame = frames[frame_num - 2]
      if prev_frame[:strike] && p_prev_frame[:strike]
        # add current ball_1 to p_prev, prev and current score
        (frame_num-2 .. frame_num).each do |num|
        frames[num][:score] += current_frame[:ball_1]
        end
      end
    end
  end

    def current_index
      frames.size-1
    end

    def previous_index
      frames.size >1 ? frames.size - 2 : nil
    end


end
