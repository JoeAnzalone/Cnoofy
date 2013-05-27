class AddEmbedCodeRawToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :embed_code_raw, :string
  end
end
