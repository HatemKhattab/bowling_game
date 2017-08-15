class GamesController < ApplicationController
  before_action :set_game, only: [:index, :play]

  def index
  end

  def play
    unless @game.over?
      @game.play
      @game.save
      session[:player] = 2
    end
    redirect_to action: 'index'
  end

  def new
    Game.first.destroy if Game.count >= 1
    redirect_to action: 'index'
  end

  private
  def set_game
    @game = Game.count ==0 ? Game.new : Game.first
  end
end
