module Spree
  LineItem.class_eval do
    has_many :product_customizations, :dependent => :destroy
  end

=begin
    # these were in older version of flexi_variants
    def cost_price
    def cost_money
    def options_text
=end
end
