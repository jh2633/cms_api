class DropHmtTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :jobs_and_keywords
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
