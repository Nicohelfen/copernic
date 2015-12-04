class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.string :name
      t.integer :start
      t.integer :actual
      t.integer :number_char

      t.timestamps null: false
    end
  end
end
