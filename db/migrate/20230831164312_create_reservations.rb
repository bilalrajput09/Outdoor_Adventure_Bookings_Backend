class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foregin_key: true 
      t.references :adventure, null: false, foregin_key: true 
      t.timestamps
    end
  end
end
