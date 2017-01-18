class CreateJobsAndKword < ActiveRecord::Migration[5.0]
  def change
    create_join_table :jobs, :keywords do |t|
      t.index :job_id
      t.index :keyword_id
    end
  end

  def down
    drop_table :jobs_and_keywords

  end
end
