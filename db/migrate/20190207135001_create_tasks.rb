class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :about
      t.string :state
      t.references :sprint, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
