class Game < ActiveRecord::Base
  attr_accessor :name
  serialize :frames, Array

  def intialize
  end
end
