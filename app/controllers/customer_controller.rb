class CustomerController < ApplicationController

  before_action :authenticate_customer!

  layout "public"

  # Main page for customers
  def index
    @candies = Candy.all
    @customer = current_customer
  end

  # Show candy info, add to cart
  def show
    @customer = current_customer
    @candy = Candy.find(params[:candy_id])
  end

  # Show cart contents
  def show_cart
    @customer = current_customer
    @grand_total = 0
  end

  def edit
    @customer = current_customer
  end

  # Allows customer to add money
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

  # Allows customer to add candies to cart
  def update_cart
    @customer = current_customer

    # Make sure candy amount is not negative
    if params[:customer][:amount].to_i < 0
      flash[:message] = "Enter a positive amount."
      redirect_to(authenticated_customer_path)
      return
    else
    # Update cart contents by adding candy_id and amount to session[]
    candy_id = params[:candy_id].to_s
    amount = params[:customer][:amount].to_s
    session[candy_id] = amount
    flash[:message] = "Candy added to cart!"
    redirect_to(authenticated_customer_path)
    end
  end

  # Allows customer to remove candies from cart
  def remove_from_cart
    # Candy ID to be deleted gets passed in, delete it from sessions and redirect
    session.delete(params[:candy_id])
    redirect_to(customer_show_cart_path)
  end

  # Allows customer to place and process and order
  def place_order
    @customer = current_customer
    @grand_total = params[:grand_total].to_f

    # Check that customer has enough balance for total order
    if @customer.money < @grand_total
      flash[:message] = "You are too poor."
      redirect_to(authenticated_customer_path)
      return
    end

    # Check that amount to buy is less than or equal to current inventory
    session.each do |candy_id, amount|
      unless candy_id == 'session_id' || candy_id == 'warden.user.customer.key' || candy_id == '_csrf_token'
        if Candy.find(candy_id).amount < amount.to_i
          flash[:message] = "You are attempting to buy more candy than is available"
          redirect_to(authenticated_customer_path)
          return
        end
      end
    end

    # Checks passed, continue processing order

    # Subtract from balance
    @customer.money = @customer.money - @grand_total
    @customer.save

    session.each do |candy_id, amount|
      unless candy_id == 'session_id' || candy_id == 'warden.user.customer.key' || candy_id == '_csrf_token'

        @candy = Candy.find(candy_id)

        @order = Order.new(:customer_id => @customer.id,
                          :store_id => @candy.shop_id,
                          :candy_name => @candy.name,
                          :candy_price => @candy.price,
                          :amount => amount.to_i)
        @order.save

        # If candy amount will be 0 after transaction...
        if @candy.amount == amount.to_i
          # Destroy candy
          @candy.destroy
        else
          # Subtract from inventory
          @candy.amount = @candy.amount - amount.to_i
          @candy.save
        end

        # Clear the candy from the session hash
        session.delete(candy_id)
      end
    end

    flash[:message] = "Order placed, thank you for shopping with us!"
    redirect_to(authenticated_customer_path)
  end

  private

  def customer_params
    params.require(:customer).permit(:money, :candy_id, :amount)
  end

end
