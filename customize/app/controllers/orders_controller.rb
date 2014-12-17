#coding: utf-8
class OrdersController < ApplicationController
  before_filter :login_required
  #予約履歴一覧
  def index
    @orders = Order.where(member_id: @current_member.id).order("order_date")
    
  end

  #新規予約
  def new
    @order = Order.new
    @lunchboxes = Lunchbox.all
    @size = Array.new
    @explanation = Array.new
    @lunchboxes.each do |lunchbox|
      @size.push([lunchbox.size, lunchbox.id])
      @explanation.push(lunchbox.explanation)
    end
  end

  #登録
  def create
    if params[:staple]
      @dishes = Dish.where(category: "主食")
      render :template=>"dishes/index"
    elsif params[:main]
      @dishes = Dish.where(category: "主菜")
      render :template => "dishes/index"
    elsif params[:sub]
      @dishes= Dish.where(category: "副菜")
      render :template => "dishes/index"
    elsif params[:check]
      @order = Order.new(params[:order])
      @lunchbox = Lunchbox.find(@order.lunchbox_id)
      render :action=>"check"
    else
      @order = Order.new(params[:order])
      if @order.save
        redirect_to @order, notice: "aa"
      else
        check
      end
    end
  end



  #予約履歴詳細
  def show
    @order = Order.find(params[:id])
  end

  #予約削除
  def destroy
  end

  #確認画面
  def check
  end
end
