# player model
class Player < ActiveRecord::Base
  has_one :game
end
