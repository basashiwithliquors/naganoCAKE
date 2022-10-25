class Admin::OrderItemsController < ApplicationController
    def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update(order_items_params)
    @order = @order_item.order

    if @order_item.production_status == "making"
      #製作ステータス製作中→製作中
      @order.update(order_status: 2)
      redirect_to admin_order_path(@order.id)
    elsif @order.order_items.count == @order.order_items.where(production_status: "complete").count

      @order.update(order_status: 3)
      redirect_to admin_order_path(@order.id)
    else
      redirect_to admin_order_path(@order.id)
    end
  end

  private
    def order_items_params
      params.require(:order_item).permit(:order_id, :item_id, :buying_price, :quantity, :production_status)
    end
end
