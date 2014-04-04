class CreateCustomizableProductOptions < ActiveRecord::Migration
  def change
    create_table :spree_customizable_product_options do |t|
      t.integer  :product_customization_type_id
      t.integer  :position
      t.string   :presentation,       :null => false
      t.string   :name,               :null => false
      t.string   :description
      t.boolean  :required,           :default => false
      t.string   :customization_image
    end
  end
end
