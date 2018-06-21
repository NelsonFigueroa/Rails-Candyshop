class CustomerController < ApplicationController

  before_action :authenticate_customer!

  layout "public"

  def index
    # Main page for customers
    @shops = Shop.all.sorted
  end



end
