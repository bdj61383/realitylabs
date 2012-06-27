class CreateContestants < ActiveRecord::Migration
  def up
    create_table :contestants do |t|
      t.string :name
      t.integer :round
      t.boolean :survive
      t.boolean :immunity
      t.boolean :merger
      t.boolean :final_three
      t.boolean :winner
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :contestants
  end
end
