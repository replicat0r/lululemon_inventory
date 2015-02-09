class Remove2ColumnsfromMarkdown < ActiveRecord::Migration
  def change
  	remove_column "store_markdowns", :initials
  	remove_column "store_markdowns", :date_changed
  end
end
