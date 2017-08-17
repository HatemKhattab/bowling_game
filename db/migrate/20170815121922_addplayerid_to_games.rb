#
class AddplayeridToGames < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.belongs_to :player, index: true
    end
  end
end
