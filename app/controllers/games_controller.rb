# Games controllers
class GamesController < ApplicationController
  before_action :set_game, only: [:index, :play1, :play2]
  before_action :game_end, only: :index
  def index
    session[:player] = 1 if session[:player].nil?
  end

  def play1
    @game1.play
    session[:player] = 2
    redirect_to action: 'index'
  end

  def play2
    @game2.play
    session[:player] = 1
    redirect_to action: 'index'
  end

  def new
    Game.all.map(&:destroy) if Game.count >= 1
    session[:game_over] = false
    session[:info] = nil
    redirect_to action: 'index'
  end

  private

  def set_game
    player1 = Player.find_by_name('player1')
    player2 = Player.find_by_name('player2')
    @game1 = player1.game.nil? ? player1.create_game : player1.game
    @game2 = player2.game.nil? ? player2.create_game : player2.game
  end

  def game_end
    if @game1.over? && @game2.over?
      session[:game_over] = true
      score1 = @game1.frames[9][:score]
      score2 = @game2.frames[9][:score]
      if score1 == score2
        session[:info] = ' Game Over!!! The two players has the same result'
      elsif score1 > score2
        session[:info] = ' Game Over!!! The winner is Player 1'
      elsif score1 < score2
        session[:info] = ' Game Over!!! The winner is Player 2'
      end
    end
  end
end
