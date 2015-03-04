class AddConfigToTask < ActiveRecord::Migration
  def change
    add_reference :tasks, :task_config
  end
end
