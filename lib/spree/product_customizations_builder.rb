module Spree
  module ProductCustomizationsBuilder

    def build_product_customizations(options)
      return unless options 

      options.each do |ct_id,cv_pair|  # customization_type_id =>
        #   {customized_product_option_id => <user input>,  etc.}
        next if cv_pair.empty? || cv_pair.values.all? {|v| v.empty?}

        # create a product_customization based on ct_id
        pc = self.product_customizations.build(:product_customization_type_id => ct_id)

        cv_pair.each_pair do |cust_opt_id, user_input|
          # create a customized_product_option based on cust_opt_id
          # and attach to its customization
          cpo = pc.customized_product_options.build(customizable_product_option_id: cust_opt_id)

          if user_input.is_a? String
            cpo.value = user_input
          else
            cpo.value = ""
            cpo.customization_image = user_input["customization_image"]
          end
        end
      end
    end
  end
end
