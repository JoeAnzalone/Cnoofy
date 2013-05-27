class AddAttachmentToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :attachment, :string
  end
end
