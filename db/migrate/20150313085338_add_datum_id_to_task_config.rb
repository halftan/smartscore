class AddDatumIdToTaskConfig < ActiveRecord::Migration
  def change
    add_reference :tasks, :datum
  end
end
