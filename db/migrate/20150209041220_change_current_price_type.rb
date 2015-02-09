class ChangeCurrentPriceType < ActiveRecord::Migration
  def up
    change_column "store_markdowns" ,"current_price",:integer
  end
  def down
    change_column "store_markdowns" ,"current_price",:string
  end
end
