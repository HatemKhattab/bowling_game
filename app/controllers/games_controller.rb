class GamesController < ApplicationController
  before_action :set_game, only: [:index, :play1, :play2]
  before_action :game_end, only: :index
  def index
    session[:player] = 1 if session[:player].nil?
  end

  def play1
    @game_1.play
    session[:player] = 2
    redirect_to action: 'index'
  end

  def play2
    @game_2.play
    session[:player] = 1
    redirect_to action: 'index'
  end

  def new
    if Game.count>= 1
      Game.all.each do |game|
        game.destroy
      end
    end
    session[:game_over] = false
    session[:info] = nil
    redirect_to action: 'index'
  end

  private
  def set_game
    player_1 = Player.find_by_name('player1')
    player_2 = Player.find_by_name('player2')
    @game_1 = player_1.game.nil? ? player_1.create_game : player_1.game
    @game_2 = player_2.game.nil? ? player_2.create_game : player_2.game
  end

  def game_end
    if @game_1.over? && @game_2.over?
      session[:game_over] = true
      score_1 = @game_1.frames[9][:score]
      score_2 = @game_2.frames[9][:score]
      session[:info] = 'Game over !!'
    end
  end
end
