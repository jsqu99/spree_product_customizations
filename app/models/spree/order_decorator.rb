module Spree

  Order.class_eval do
    def product_customizations_match(line_item,new_customizations)
      existing_customizations = line_item.product_customizations

      if new_customizations.kind_of? ActiveSupport::HashWithIndifferentAccess
        # if there aren't any customizations, there's a 'match'
        return true if existing_customizations.empty? && new_customizations.empty?
        # exact match of all customization types?
        return false unless existing_customizations.map(&:product_customization_type_id).sort == new_customizations.keys.map(&:to_i).sort

        a = []
        new_customizations.values.each do |ncv_hash| 
          ncv_hash.keys.each do |key|
            a<< [key.to_i, ncv_hash[key]]
          end
        end
  
        new_vals = Set.new a
      else
        new_customizations = new_customizations.product_customizations

        # if there aren't any customizations, there's a 'match'
        return true if existing_customizations.empty? && new_customizations.empty?
        # exact match of all customization types?
        return false unless existing_customizations.map(&:product_customization_type_id).sort == new_customizations.map(&:product_customization_type_id).sort

        new_vals = customization_pairs(new_customizations)
      end
  
  
      # get a list of [customizable_product_option.id,value] pairs
      existing_vals = customization_pairs(existing_customizations)
      # do a set-compare here
      existing_vals == new_vals
    end

    self.register_line_item_comparison_hook(:product_customizations_match)

    private
      # produces a list of [customizable_product_option.id,value] pairs for subsequent comparison
      def customization_pairs(product_customizations)
        pairs= product_customizations.map(&:customized_product_options).flatten.map do |m|
          [m.customizable_product_option.id, m.value.present? ? m.value : m.customization_image.to_s ]
        end

        Set.new pairs
      end
  end
end
