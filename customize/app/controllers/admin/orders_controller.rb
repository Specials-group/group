# coding: utf-8
class Admin::OrdersController < Admin::Base
  def index
    now_t = Date.today
    now_new_t = Time.local(now_t.year, now_t.month, now_t.day, 0, 0, 0).strftime("%Y-%m-%d %H:%M:%S")
    now_end_t = Time.local(now_t.year, now_t.month, now_t.day, 23, 59, 59).strftime("%Y-%m-%d %H:%M:%S")
    @today_order = Order.order("receive_date").find(:all, :conditions => ["receive_date > ? and receive_date < ?", now_new_t.to_s, now_end_t.to_s])
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

    @future_order = Order.paginate(
      :conditions => ["receive_date > ?", now_end_t.to_s],
      :page => params[:page],
      :order => 'receive_date',
      :per_page => 10
    )
    @a_size = Array.new
    @a_staple = Array.new
    @a_main = Array.new
    @a_sub = Array.new
    @future_order.each do |order|
      case order.lunchbox_id
      when 0
        @a_size.push("大")
      when 1
        @a_size.push("普通")
      when 2
        @a_size.push("小")
      end
      @a_staple.push(Dish.find(order.staple_id+1).name)
      @a_main.push(Dish.find(order.main_id+1).name)
      @a_sub.push(Dish.find(order.sub_id+1).name)
    end
  end

  def all_order
    @all_order = Order.paginate(
      :page => params[:page],
      :order => 'receive_date',
      :per_page => 10
    )
    @size = Array.new
    @staple = Array.new
    @main = Array.new
    @sub = Array.new
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
      redirect_to [:admin, @order], notice: "予約情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to :admin_orders, notice: "予約情報を削除しました。"
  end
end
