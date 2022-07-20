class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  def index
    @genre = Genre.new
    @genres = create_order
  end

  def create
    @genre = Genre.new(genre_params)
    @genres = create_order
    @genre.save
  end

  def edit
    @genre = Genre.find(params[:id])
    @genres = create_order
  end

  def update
    @genre = Genre.find(params[:id])
    @genres = update_order
    @genre.update(genre_params)
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def create_order
    Genre.page(params[:page]).order(created_at: :DESC)
  end

  def update_order
    Genre.page(params[:page]).order(updated_at: :DESC)
  end

end
