class AddMarkdownToStoreMarkdowns < ActiveRecord::Migration
  def change
  	add_column "store_markdowns",:markdowns,:string
  end
end
