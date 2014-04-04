class CreateProductCustomizationTypes < ActiveRecord::Migration
  def change
    create_table :spree_product_customization_types do |t|
      t.string :name
      t.string :presentation
      t.string :description
    end

    create_table :spree_product_customization_types_products, :id => false do |t|
      t.integer :product_customization_type_id
      t.integer :product_id
    end

  end
end
