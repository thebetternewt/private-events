class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.references :event, foreign_key: true
      t.integer :invitee_id

      t.timestamps
    end
    add_index :invitations, :invitee_id
  end
end
