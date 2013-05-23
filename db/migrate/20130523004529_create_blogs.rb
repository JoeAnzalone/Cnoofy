class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :subdomain
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
