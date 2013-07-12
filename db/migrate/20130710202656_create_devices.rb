class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :uuid
      t.string :status
      t.text :state
      t.string :name
      t.string :ip
      t.integer :port

      t.timestamps
    end
    add_index :devices, :uuid, :unique => true
  end
end
