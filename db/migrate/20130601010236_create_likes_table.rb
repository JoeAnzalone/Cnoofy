class CreateLikesTable < ActiveRecord::Migration
  def self.up
    create_table :likes, :id => false do |t|
        t.references :post
        t.references :user
    end
    add_index :likes, [:post_id, :user_id]
    add_index :likes, :user_id
  end

  def self.down
    drop_table :likes
  end
end