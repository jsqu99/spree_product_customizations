class CreateProductCustomizations < ActiveRecord::Migration
  def change
    create_table :spree_product_customizations do |t|
      t.integer :line_item_id
      t.integer :product_customization_type_id
    end
  end
end
