class AddDefaultValueToTasksFinishedAt < ActiveRecord::Migration
  def change
    change_column :tasks, :finished_at, :datetime, :default => nil
  end
end
