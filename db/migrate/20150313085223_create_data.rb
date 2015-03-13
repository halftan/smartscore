class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.string :path
      t.integer :size
      t.string :label

      t.timestamps null: false
    end
  end
end
