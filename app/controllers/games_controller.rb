class GamesController < ApplicationController
  before_action :set_game, only: [:index, :play1]

  def index
    #session[:player] = 1 if session[:player].nil?
  end

  def play1
      # @game.play
      # @game.save
    @game_1.play
    @game_1.save
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
    #player_1 = Player.first
    player_2 = Player.find_by_name('player2')
    #@game_1 = player_1.game.nil? ? player_1.create_game : @player_1.game
    @game_1 = player_1.game.nil? ? player_1.create_game : player_1.game
  end
end
