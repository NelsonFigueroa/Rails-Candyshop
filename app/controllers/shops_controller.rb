class ShopsController < ApplicationController

  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)

    if @shop.save
      flash[:message] = "New shop \"" + @shop.name + "\" created!"
      redirect_to(shops_path)
    else
      flash[:message] = "Invalid input!"
      render('new')
    end

  end

  # def edit
  # end

  # def update
  # end

  def delete
    @shop = Shop.find(params[:id])
  end

  def destroy
    @shop = Shop.find(params[:id])

    @shop.destroy
    flash[:message] = "Shop deleted."
    redirect_to(shops_path)
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :city)
  end

end
