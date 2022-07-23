class Public::HomesController < ApplicationController
  def top
    @slide_items = Item.order("RANDOM()").limit(5)
    @items = Item.order('id DESC').limit(4)
    @genres = Genre.all
  end

  def about
  end
end
