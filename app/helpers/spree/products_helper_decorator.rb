module Spree
  ProductsHelper.module_eval do
    def calculator_name(product_customization_type)
      product_customization_type.calculator.class.name.demodulize.underscore rescue ""
    end
  end
end
