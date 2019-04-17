class AddDeadlineToSprints < ActiveRecord::Migration[5.2]
  def change
    add_column :sprints, :deadline, :datetime
  end
end
