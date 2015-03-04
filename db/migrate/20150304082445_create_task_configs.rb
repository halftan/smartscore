class CreateTaskConfigs < ActiveRecord::Migration
  def change
    create_table :task_configs do |t|
      t.string :name
      t.text :param

      t.timestamps null: false
    end
  end
end
