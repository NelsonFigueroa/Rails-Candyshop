class CandiesController < ApplicationController

  before_action :authenticate_user!
  before_action :get_shop

  # def index
  # end

  # def show
  # end

  def new
    @candy = Candy.new(:shop_id => @shop.id)
    if !candy_belongs_to_user(@candy)
      flash[:message] = "This shop does not exist in your database."
      redirect_to(shops_path)
    end
  end

  def create
    @candy = Candy.new(candy_params)
    @candy.shop_id = @shop.id

    if @candy.save
      flash[:message] = "Candy \"" + @candy.name + "\" created!"
      redirect_to(shop_path(:id => @shop.id))
    else
      flash[:message] = "Invalid candy fields."
      render('new')
    end
  end

  def edit
    @candy = Candy.find(params[:id])
    if !candy_belongs_to_user(@candy)
      flash[:message] = "This shelf does not exist in your database."
      redirect_to(shops_path)
    end
  end

  def update
    @candy = Candy.find(params[:id])

    # Assign shelf_id to variable
    @shelf_id = candy_params[:shelf_id]

    # Method call to model to make sure shelf is valid
    if @shelf_id.blank? || @candy.valid_shelf(@shelf_id) == true
      if @candy.update_attributes(candy_params)
        flash[:message] = "Candy moved"
        redirect_to(shop_path(:id => @shop.id))
      else
        # If unable to save, render edit
        render('edit')
      end
    else
      # Shelf is not valid
      flash[:message] = "Shelf must be in current shop."
      render('edit')
    end
  end # End update action

  def delete
    @candy = Candy.find(params[:id])
    if !candy_belongs_to_user(@candy)
      flash[:message] = "This candy does not exist in your database."
      redirect_to(shops_path)
    end
  end

  def destroy
    @candy = Candy.find(params[:id])
    @candy.destroy
    flash[:message] = "Candy deleted."
    redirect_to(shop_path(:id => @shop.id))
  end

  private

  # Used when creating new candies or moving candies
  def candy_params
    params.require(:candy).permit(:name, :amount, :shop_id, :shelf_id)
  end

  # Used to maintain appropriate shop_id throughout views
  def get_shop
    @shop = Shop.find(params[:shop_id])
  end

  # Used to make sure candy belong to appropriate shop

  def candy_belongs_to_user(candy)
    if candy.shop.user_id == current_user.id
      return true
    else
      return false
    end
  end

end
