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

    # Do not allow user to enter negative money value
    if params[:customer][:money].to_f < 0
      flash[:message] = "Enter a positive value."
      redirect_to(edit_customer_path)
      return
    end

    # Add money manually then include it in update params
    @sum = @customer.money + params[:customer][:money].to_f
    params[:customer][:money] = @sum

    if @customer.update_attributes(customer_params)
      flash[:message] = "Money added!"
      redirect_to(authenticated_customer_path)
      return
    else
      # If unable to save, render edit
      flash[:message] = "Invalid input!"
      redirect_to(edit_customer_path)
    end
  end

  def update_cart
    # Update cart contents by adding candy_id and amount to session[]
    @customer = current_customer

    candy_id = params[:candy_id].to_s
    amount = params[:customer][:amount].to_s
    session[candy_id] = amount
    flash[:message] = "Candy added to cart!"
    redirect_to(authenticated_customer_path)
  end

  def remove_from_cart
    session.delete(params[:candy_id])
    redirect_to(customer_show_cart_path)
  end

  private

  def customer_params
    params.require(:customer).permit(:money, :candy_id, :amount)
  end

end
