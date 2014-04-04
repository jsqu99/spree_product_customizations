class CreateCustomizedProductOptions < ActiveRecord::Migration
  def change
    create_table :spree_customized_product_options do |t|
      t.integer :product_customization_id
      t.integer :customizable_product_option_id
      t.string :value
    end
  end
end
