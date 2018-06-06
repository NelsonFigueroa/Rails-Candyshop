class ShopsController < ApplicationController

  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
    @unshelved_candies = @shop.candies.unshelved
    @shelved_candies = @shop.candies.shelved

    # To be used in loop: @shop.shelves.each do |shelf|
    #   Candies in each shelf
    #   figure it out, must match shelf id and shop id.
    #   @shop.shelf.candies.each do |candy|
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
    @shop.destroy
    redirect_to(shops_path)
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :city)
  end

end
