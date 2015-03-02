class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.datetime :finished_at
      t.integer :status
      t.text :content

      t.timestamps null: false
    end
  end
end
