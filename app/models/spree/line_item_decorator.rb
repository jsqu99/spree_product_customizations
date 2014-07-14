module Spree
  LineItem.class_eval do
    has_many :product_customizations, :dependent => :destroy

    include ProductCustomizationsBuilder
  end
end
