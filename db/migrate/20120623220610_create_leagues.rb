class CreateLeagues < ActiveRecord::Migration
  def up
    create_table :leagues do |t|
      t.string :name
      t.string :confirmation_code
      t.text :contestant_pool
      t.text :scoring_system
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :leagues
  end
end