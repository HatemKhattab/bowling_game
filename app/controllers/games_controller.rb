class GamesController < ApplicationController
  before_action :set_game, only: [:index, :play1, :play2]

  def index
    #session[:player] = 1 if session[:player].nil?
  end

  def play1
    @game_1.play
    redirect_to action: 'index'
  end

  def play2
    @game_2.play
    redirect_to action: 'index'
  end

  def new
    if Game.count>= 1
      Game.all.each do |game|
        game.destroy
      end
    end
    redirect_to action: 'index'
  end

  private
  def set_game
    player_1 = Player.find_by_name('player1')
    player_2 = Player.find_by_name('player2')
    @game_1 = player_1.game.nil? ? player_1.create_game : player_1.game
    @game_2 = player_2.game.nil? ? player_2.create_game : player_2.game
  end
end
