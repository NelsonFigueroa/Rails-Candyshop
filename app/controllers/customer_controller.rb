class CustomerController < ApplicationController

  before_action :authenticate_customer!

  layout "public"

  def index
    # Main page for customers
    @candies = Candy.all
    @customer = current_customer
  end

  def show
    # Show candy info
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update!(money: @customer.money + params[:customer][:money].to_f)
    redirect_to(authenticated_customer_path)

    # if @customer.update_attributes(customer_params)
    #   flash[:message] = "Money added!"
    #   redirect_to(authenticated_customer_path)
    # else
    #   # If unable to save, render edit
    #   flash[:message] = "Invalid input!"
    #   render('edit')
    # end
  end

  private

  def customer_params
    params.require(:customer).permit(:money)
  end

end
