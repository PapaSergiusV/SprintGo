class AddDoneTimeToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :done_time, :datetime
  end
end
