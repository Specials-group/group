#coding : utf-8
class Admin::DishesController < Admin::Base
  def index    
    @dishes = Dish.all
  end

  def show
    @dish = Dish.find(params[:id])
    if params[:format].in?(["jpg", "png", "gif"])
      send_image
    else
      render "admin/dishes/show"
    end
  end

  def new
    @dish = Dish.new
    @dish.build_image 
  end

  def create
    @dish = Dish.new(params[:dish])
    if @dish.save
      redirect_to [:admin, @dish], notice: "料理を登録しました。"
    else
      render "new"
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
      redirect_to [:admin, @dish], notice: "料理の情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @dish = Dish.find(params[:id])
    @dish.destroy
    redirect_to :admin_dishes, notice: "料理を削除しました。"
  end

  def search
    @dishes = Dish.search(params[:q])
    render "index"
  end


  private
  def send_image
    if @dish.image.present?
      send_data @dish.image.data,
        type: @dish.image.content_type, disposition: "inline"
    end
  end
end
