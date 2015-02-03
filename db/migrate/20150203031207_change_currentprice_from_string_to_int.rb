class ChangeCurrentpriceFromStringToInt < ActiveRecord::Migration
  def up
  	change_column :store_markdowns, :original_price, :integer
  end

  def down
  	change_column :store_markdowns, :original_price, :string
  end
end
