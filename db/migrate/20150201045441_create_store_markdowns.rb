class CreateStoreMarkdowns < ActiveRecord::Migration
  def change
    create_table :store_markdowns do |t|
      t.string :item_name
      t.string :colour
      t.integer :original_price
      t.integer :current_price
      t.integer :markdown 
      

      t.timestamps
    end
  end
end
