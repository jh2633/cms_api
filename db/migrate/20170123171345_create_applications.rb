class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :email
      t.text :cover
      t.text :cv

      t.timestamps
    end
  end
end
