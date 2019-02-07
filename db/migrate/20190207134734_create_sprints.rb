class CreateSprints < ActiveRecord::Migration[5.2]
  def change
    create_table :sprints do |t|
      t.string :name
      t.string :period
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
