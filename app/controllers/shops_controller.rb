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
      redirect_to(shops_path)
    else
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

    # Destroy all shelves in shop
    @shop.shelves.each do |shelf|
      shelf.destroy
    end

    # Destroy all candies in shop
    @shop.candies.each do |candy|
      candy.destroy
    end

    @shop.destroy
    redirect_to(shops_path)
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :city)
  end

end
