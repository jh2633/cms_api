class RemoveJoinTableKeywordJob < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs_and_keywords, id: false do |t|
      t.belongs_to :job, index: true
      t.belongs_to :keyword, index: true
    end
  end

  def up
    drop_table :jobs_keywords
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
