class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.datetime :begin_date
      t.datetime :end_date
      t.text :details
      t.integer :creator_id

      t.timestamps
    end

    add_index(:events, [:begin_date, :creator_id])
  end
end
