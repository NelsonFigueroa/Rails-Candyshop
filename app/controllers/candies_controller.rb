class CandiesController < ApplicationController
  def index

  end

  # def show
  # end

  def new
    @candy = Candy.new
  end

  def create
    @candy = Candy.new(candy_params)

    if @candy.save
      redirect_to(shop_path)
    else
      render('new')
    end

  end

  private

  def candy_params
    params.require(:candy).permit(:name, :calories, :amount)
  end

end
