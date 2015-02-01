class CreateStoreMarkdowns < ActiveRecord::Migration
  def change
    create_table :store_markdowns do |t|
      t.string :item_name
      t.string :colour
      t.string :original_price
      t.string :current_price
      t.string :initials
      t.string :date_changed

      t.timestamps
    end
  end
end
