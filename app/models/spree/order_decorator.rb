module Spree

  Order.class_eval do
    # TODO: need to do something about def merge!.  Not sure how to have the line_item be aware of 
    # all the customizations it should compare.  Maybe we should go w/ a registration of extension-specific
    # modifiers approach vs. using send(:name_of_option) to call methods.  That way we'd know about these
    # fields always and not just when we are presented w/ an options hash
    # 
    private
    # produces a list of [customizable_product_option.id,value] pairs for subsequent comparison
    def customization_pairs(product_customizations)
      pairs= product_customizations.map(&:customized_product_options).flatten.map do |m|
        [m.customizable_product_option.id, m.value.present? ? m.value : m.customization_image.to_s ]
      end

      Set.new pairs
    end


    def product_customizations_match(line_item,new_customizations)
      existing_customizations = line_item.product_customizations

      # if there aren't any customizations, there's a 'match'
      return true if existing_customizations.empty? && new_customizations.empty?

      # exact match of all customization types?
      return false unless existing_customizations.map(&:product_customization_type_id).sort == new_customizations.map(&:product_customization_type_id).sort

      # get a list of [customizable_product_option.id,value] pairs
      existing_vals = customization_pairs existing_customizations
      new_vals      = customization_pairs new_customizations

      # do a set-compare here
      existing_vals == new_vals
    end
  end
end
