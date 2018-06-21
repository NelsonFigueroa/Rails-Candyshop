class PublicController < ApplicationController

  layout "public"

  def index
    # Landing page
    @title = "Home"
  end

  def about
    # About page
    @title = "About"
  end
end
