require 'spec_helper'

describe Spree::OrdersController do
  let(:user) { create(:user) }

  context "Order model mock" do
    let(:order) do
      Spree::Order.create
    end

    before do
      controller.stub(:try_spree_current_user => user)
    end

    context "#populate" do
      let(:populator) { double('OrderPopulator') }

      before do
        Spree::OrderPopulator.should_receive(:new).and_return(populator)
      end

      it "should handle population" do
        populator.should_receive(:populate).with("2", "5").and_return(true)
        spree_post :populate, { :order_id => 1, :variant_id => 2, :quantity => 5 }
        response.should redirect_to spree.cart_path
      end

    end

    context "#update" do
      before do
        controller.stub :check_authorization
      end

      it "should redirect to cart path (on success)" do
        controller.stub current_order: order
        order.stub(:update_attributes).and_return true
        spree_put :update, {}, {:order_id => 1}
        response.should redirect_to(spree.cart_path)
      end
    end
  end
end
