class ShopsController < ApplicationController

  before_action :authenticate_user!

  def index
    @shops = current_user.shops.sorted

    # Count of Orders for current user
    @orders = Order.where(:user_id => current_user.id).count

    # Total revenue of shops
    @revenue = Order.where(:user_id => current_user.id).sum(:total)

    # For pie chart revenue split
    @revenue_split = Order.group(:store_id).where(:user_id => current_user.id).sum(:total)

  end

  def show
    @shop = Shop.find(params[:id])
    if !@shop.shop_belongs_to_user(current_user)
      flash[:message] = "This shop does not exist in your database."
      redirect_to(shops_path)
    end

    # Gathering all existing shelves to display in drop-down
    @shelf_id_nums = []
    @shop.shelves.each do |shelf|
      @shelf_id_nums << shelf.id.to_s
    end
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user_id = current_user.id

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
    if !@shop.shop_belongs_to_user(current_user)
      flash[:message] = "This shop does not exist in your database."
      redirect_to(shops_path)
    end
  end

  def destroy
    @shop = Shop.find(params[:id])

    @shop.destroy
    flash[:message] = "Shop deleted."
    redirect_to(shops_path)
  end

  private

  # Used when creating new shops
  def shop_params
    params.require(:shop).permit(:name, :city, :user_id)
  end

end
