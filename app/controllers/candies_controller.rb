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

  private

  def candy_params
    params.require(:candy).permit(:name, :amount, :shop_id)
  end

  def get_shop
    @shop = Shop.find(params[:shop_id])
  end

end
