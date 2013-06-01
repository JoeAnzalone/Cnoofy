class AddIndexToLikes < ActiveRecord::Migration
  def change
    add_index :likes, [ :user_id, :post_id ], :unique => true, :name => 'by_post_and_user'
  end
end