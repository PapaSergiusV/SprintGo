class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :logo
      t.text :about
      t.text :address
      t.text :phone

      t.timestamps
    end
  end
end
