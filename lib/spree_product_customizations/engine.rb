module SpreeProductCustomizations
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_product_customizations'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc

    initializer "spree.product_customizations.register.calculators" do |app|
      app.config.spree.calculators.add_class('product_customization_types')
      app.config.spree.calculators.product_customization_types = [
                                                                    Spree::Calculator::Engraving,
                                                                    Spree::Calculator::AmountTimesConstant,
                                                                    Spree::Calculator::ProductArea,
                                                                    Spree::Calculator::CustomizationImage,
                                                                    Spree::Calculator::NoCharge
                                                                   ]
    end

  end
end
