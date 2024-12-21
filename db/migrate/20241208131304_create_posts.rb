class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.datetime :scheduled_at
      t.datetime :published_at
      t.bigint :job_id

      t.timestamps
    end
  end
end
