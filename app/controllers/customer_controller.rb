class CustomerController < ApplicationController

  before_action :authenticate_customer!

  layout "public"

  def index
    # Main page for customers
    @candies = Candy.all
    @customer = current_customer
  end

  def show
    # Show candy info, add to cart
    @customer = current_customer
    @candy = Candy.find(params[:candy_id])
  end

  def show_cart
    # Show cart contents (cookies)
    # Access key and value
    @customer = current_customer
    @grand_total = 0
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    # Add money manually then include it in update params
    @sum = @customer.money + params[:customer][:money].to_f
    params[:customer][:money] = @sum

    if @customer.update_attributes(customer_params)
      flash[:message] = "Money added!"
      redirect_to(authenticated_customer_path)
    else
      # If unable to save, render edit
      flash[:message] = "Invalid input!"
      render('edit')
    end
  end

  def update_cart
    # Update cart contents
    @customer = current_customer

    candy_id = params[:candy_id].to_s
    amount = params[:customer][:amount].to_s
    session[candy_id] = amount
    flash[:message] = "Candy added to cart!"
    redirect_to(authenticated_customer_path)
  end

  private

  def customer_params
    params.require(:customer).permit(:money, :candy_id, :amount)
  end

end
