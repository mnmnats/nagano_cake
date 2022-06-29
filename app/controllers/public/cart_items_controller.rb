class Public::CartItemsController < ApplicationController
    def new
        @cart_item = CartItem.new
    end

    def index
        @cart_items = current_customer.cart_items.all
        @total = 0
    end

    def update
        cart_item = current_customer.cart_items.find(params[:id])
        amount = params[:cart_item] [:amount]
        cart_item.update(amount: amount)
        redirect_to cart_items_path
    end
    def destroy_all
        cart_items = CartItem.all
        cart_items.destroy_all
        redirect_to cart_items_path
    end   

    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        redirect_to cart_items_path
    end

    def create
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.customer_id = current_customer.id
        if 
        @cart_item.save
        redirect_to cart_items_path
        else
        @item = Item.find(cart_item_params[:item_id])
        @genres = Genre.all
      render "public/items/show"
        end
    end

    private

    def cart_item_params
        params.require(:cart_item).permit(:amount, :item_id)
    end
end