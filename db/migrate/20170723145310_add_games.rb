#
class AddGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :frames
    end
  end
end
