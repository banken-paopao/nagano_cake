class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

  def item_search
    @model = params[:model]
    if @model == "item"
      unless params[:content] == ""
        @genres = Genre.all
        @search_name = params[:content]
        @search_result = Item.search_for(@model, @search_name)
      else
        flash[:danger] = "商品名を入力してください"
        redirect_to items_path
      end
    else
      @genres = Genre.all
      search_genre = params[:genre_id]
      @search_result = Item.search_for(@model, search_genre)
      @search_name = Genre.find(search_genre).name
    end
  end
end
