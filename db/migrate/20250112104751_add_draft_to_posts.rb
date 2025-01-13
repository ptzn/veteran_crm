class AddDraftToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :draft, :boolean, null: false, default: false
  end
end
