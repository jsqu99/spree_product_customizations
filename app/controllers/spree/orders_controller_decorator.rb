module Spree
  OrdersController.class_eval do

    include ProductCustomizations

    before_filter :load_product_customizations, only: :populate

    private
      def load_product_customizations
        params[:variant_modifier_hash][product_customizations: product_customizations_from_params]
      end
  end
end
