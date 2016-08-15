class CreateEventAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :event_attendances do |t|
      t.integer :attended_event_id
      t.integer :attendee_id

      t.timestamps
    end
    add_index :event_attendances, :attended_event_id
    add_index :event_attendances, :attendee_id
  end
end
