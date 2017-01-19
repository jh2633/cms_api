class ChangeJobCategoryAssociation < ActiveRecord::Migration[5.0]
  def change
    remove_column :jobs, :category, :string
    add_reference :jobs, :category, foreign_key: true
  end
end
