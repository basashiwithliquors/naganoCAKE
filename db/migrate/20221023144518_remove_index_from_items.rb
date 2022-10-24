class RemoveIndexFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_index :items, :genre_id
  end
end
