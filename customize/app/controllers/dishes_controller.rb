#coding : utf-8
class DishesController < ApplicationController
  def index    
    @dishes = Dish.all
    if(session[:status] != nil)
      @dishes = Dish.where(category: session[:status])
    else
      @dishes = Dish.all
    end
  end
  
  def top
    session.delete(:status)
    session.delete(:order)
    @dishes = Dish.all
    if(session[:status] != nil)
      @dishes = Dish.where(category: session[:status])
    else
      @dishes = Dish.all
    end
    render "index"
  end

  def show
    @dish = Dish.find(params[:id])
    if params[:format].in?(["jpg", "png", "gif"])
      send_image
    else
      render "dishes/show"
    end
  end

  def new
    @dish = Dish.new
    @dish.build_image 
  end

  def create
    @dish = Dish.new(params[:dish])
    if @dish.save
      redirect_to @dish
    else
      render "new", notice: "料理を登録しました。"
    end
  end

  def edit
    @dish = Dish.find(params[:id])
    @dish.build_image unless @dish.image
  end

  def update
    @dish = Dish.find(params[:id])
    @dish.assign_attributes(params[:dish])
    if @dish.save
      redirect_to @dish, notice: "料理の情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @dish = Dish.find(params[:id])
    @dish.destroy
    redirect_to :dishes
  end

  def search
    @dishes = Dish.search(params[:q])
    render "index"
  end

  def order
    session[session[:status]] = Dish.find(params[:id])
    @dish = Dish.find(params[:id])
    case @dish.category
      when "staple"
        session[:order].staple_id = @dish.id
      when "main"
        session[:order].main_id = @dish.id
      when "sub"
        session[:order].sub_id = @dish.id
    end
    redirect_to :controller=>"orders", :action=>"new", :name => "select" 
    
  end


  private
  def send_image
    if @dish.image.present?
      send_data @dish.image.data,
        type: @dish.image.content_type, disposition: "inline"
    end
  end
end
