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

  def update_cart
    # Update cart contents (cookies)
    candy_id = params[:candy_id].to_s
    amount = params[:customer][:amount].to_s
    # cookies[:candies] = { candy_id => amount }
    cookies[candy_id] = amount
    flash[:message] = "Candy added to cart!"
    redirect_to(authenticated_customer_path)
  end

  private

  def customer_params
    params.require(:customer).permit(:money, :candy_id, :amount)
  end

end
