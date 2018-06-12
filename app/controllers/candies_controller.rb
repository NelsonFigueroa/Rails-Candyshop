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
      flash[:message] = "Candy \"" + @candy.name + "\" created!"
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
  end

  def destroy
    @candy = Candy.find(params[:id])
    @candy.destroy
    flash[:message] = "Candy deleted."
    redirect_to(shop_path(:id => @shop.id))
  end

  private

  # Used when creating new candies
  def candy_params
    params.require(:candy).permit(:name, :amount, :shop_id, :shelf_id)
  end

  # Used to maintain appropriate shop_id throughout views
  def get_shop
    @shop = Shop.find(params[:shop_id])
  end

end
