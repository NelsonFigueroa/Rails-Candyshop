class ShelvesController < ApplicationController

  before_action :authenticate_user!
  before_action :get_shop

  # def index
  # end

  # def show
  # end

  # def new
  # end

  def create
    @shelf = Shelf.new(:shop_id => @shop.id)

    if @shelf.save
      flash[:message] = "New shelf created!"
      redirect_to(shop_path(:id => @shop.id))
    else
      # Flash hash with message: "Save failed" or whatever
      redirect_to(shop_path(:id => @shop.id))
    end
  end

  # def edit
  # end

  # def update
  # end

  def delete
    @shelf = Shelf.find(params[:id])
    if !@shelf.shelf_belongs_to_user(current_user)
      flash[:message] = "This shelf does not exist in your database."
      redirect_to(shops_path)
    end
  end

  def destroy
    @shelf = Shelf.find(params[:id])

    # Set all candies in shelf to unshelved
    @shelf.candies.each do |candy|
      candy.shelf_id = nil
      candy.save
    end

    @shelf.destroy
    flash[:message] = "Shelf deleted."
    redirect_to(shop_path(:id => @shop.id))
  end

  private

  # Used to maintain appropriate shop_id throughout views
  def get_shop
    @shop = Shop.find(params[:shop_id])
  end

end
