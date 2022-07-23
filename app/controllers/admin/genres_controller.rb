class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  def index
    @genre = Genre.new
    @genres = Genre.create_order(params[:page])
  end

  def create
    @genre = Genre.new(genre_params)
    @genres = Genre.create_order(params[:page])
    @genre.save
  end

  def edit
    @genre = Genre.find(params[:id])
    @genres = Genre.create_order(params[:page])
  end

  def update
    @genre = Genre.find(params[:id])
    @genres = Genre.update_order(params[:page])
    @genre.update(genre_params)
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
