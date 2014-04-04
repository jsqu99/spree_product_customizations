module Spree
  Product.class_eval do
    # allowed customizations
    has_and_belongs_to_many :product_customization_types
  end
end
