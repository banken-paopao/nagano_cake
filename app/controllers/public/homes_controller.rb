class Public::HomesController < ApplicationController
  def top
    @slide_items = Item.all.limit(5)
    @items = Item.last(4)
    @genres = Genre.all
  end

  def about
  end
end
