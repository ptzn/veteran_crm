class ChangePostsJobIdType < ActiveRecord::Migration[8.0]
  def change
    change_column :posts, :job_id, :string
  end
end
