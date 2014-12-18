# coding: utf-8
class Admin::OrdersController < Admin::Base
  def index
    @today_order = Order.limit(3)
    @all_order = Order.all
    @size = Array.new
    @staple = Array.new
    @main = Array.new
    @sub = Array.new
    @today_order.each do |order|
      case order.lunchbox_id
      when 0
        @size.push("大")
      when 1
        @size.push("普通")
      when 2
        @size.push("小")
      end

      @staple.push(Dish.find(order.staple_id+1).name)
      @main.push(Dish.find(order.main_id+1).name)
      @sub.push(Dish.find(order.sub_id+1).name)
    end

    @all_order.each do |order|
      case order.lunchbox_id
      when 0
        @size.push("大")
      when 1
        @size.push("普通")
      when 2
        @size.push("小")
      end

      @staple.push(Dish.find(order.staple_id+1).name)
      @main.push(Dish.find(order.main_id+1).name)
      @sub.push(Dish.find(order.sub_id+1).name)
    end
  end

  def show
    @order = Order.find(params[:id])
    @staple = Dish.find(@order.staple_id+1)
    @main = Dish.find(@order.main_id+1)
    @sub = Dish.find(@order.sub_id+1)
    @size = Array.new
    @lunchbox = Lunchbox.find(@order.lunchbox_id+1)
  end

  def edit
    @order = Order.find(params[:id])
    @lunchboxes = Lunchbox.all
    @size = Array.new
    @explanation = Array.new
    @lunchboxes.each do |lunchbox|
      @size.push([lunchbox.size, lunchbox.id])
      @explanation.push(lunchbox.explanation)
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.assign_attributes(params[:order])
    if @order.save
      redirect_to @order, notice: "予約情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to :orders, notice: "予約情報を削除しました。"
  end
end
