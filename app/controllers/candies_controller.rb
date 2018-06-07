class CandiesController < ApplicationController

  before_action :get_shop

  def index

  end

  # def show
  # end

  def new
    @candy = Candy.new(:shop_id => @shop.id)
  end

  def create
    @candy = Candy.new(candy_params)
    @candy.shop_id = @shop.id

    if @candy.save
      redirect_to(shop_path(:id => @shop.id))
    else
      render('new')
    end
  end

  def edit
    @candy = Candy.find(params[:id])
  end

  def update
    @candy = Candy.find(params[:id])

    # Ensure that if shelf_id is not null, shelf and candy are in the same shop 

    if @candy.update_attributes(update_params)
      redirect_to(shop_path(:id => @shop.id))
    else
      render('edit')
    end
  end

  def delete
    @candy = Candy.find(params[:id])
  end

  def destroy
    @candy = Candy.find(params[:id])
    @candy.destroy
    redirect_to(shop_path(:id => @shop.id))
  end

  private

  # Used when creating new candies
  def candy_params
    params.require(:candy).permit(:name, :amount, :shop_id)
  end

  # Used when updating candies and moving from shelves
  def update_params
    params.require(:candy).permit(:shelf_id)
  end

  def get_shop
    @shop = Shop.find(params[:shop_id])
  end

end
