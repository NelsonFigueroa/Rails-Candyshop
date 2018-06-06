class ShelvesController < ApplicationController

  before_action :get_shop

  def index
  end

  # def show
  # end

  # def new
  # end

  def create
    @shelf = Shelf.new(:shop_id => @shop.id)

    if @shelf.save
      redirect_to(shop_path(:id => @shop.id))
    else
      # Flash hash with message: "Save failed" or whatever
      redirect_to(shop_path(:id => @shop.id))
    end
  end

  def delete
  end

  def destroy
  end

  private

  def get_shop
    @shop = Shop.find(params[:shop_id])
  end

end
