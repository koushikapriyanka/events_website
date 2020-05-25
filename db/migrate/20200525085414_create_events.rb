class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :ticket_fee
      t.datetime :timing

      t.timestamps
    end
  end
end
