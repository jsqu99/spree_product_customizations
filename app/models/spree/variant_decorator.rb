module Spree
  Variant.class_eval do
    include ProductCustomizationsBuilder

    def product_customizations_price_modifier_amount_in(currency, options)
      # we need to build (but not save) a line item so we can
      # reuse some code.  A small price to pay IMO
      li = LineItem.new
      li.build_product_customizations(options)
      li.product_customizations.map(&:price).sum
    end
  end
end
