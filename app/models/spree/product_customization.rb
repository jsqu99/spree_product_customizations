module Spree
  class ProductCustomization < ActiveRecord::Base
    belongs_to :product_customization_type
    belongs_to :line_item
    has_many :customized_product_options, :dependent => :destroy

    # price might depend on something contained in the variant
    # (like product property value), so optionally pass that in
    def price(variant=nil)
      product_customization_type.calculator.compute(self, variant)
    end

    def calculator
      product_customization_type.calculator
    end
  end
end
