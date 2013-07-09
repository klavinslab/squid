class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.string :uuid
      t.binary :data

      t.timestamps
    end
  end
end
