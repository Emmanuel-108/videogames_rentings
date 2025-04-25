class VideogamesController < ApplicationController
  def index
    @videogames = Videogame.all
  end

  def new
    @videogame = Videogame.new
  end

  def create
    @videogame = Videogame.new(videogame_params)
    if @videogame.save
      redirect_to root_path(@videogame)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @videogame = Videogame.find(parms[:id])
  end

  def update
  end

  def destroy
  end

  private

  def videogame_params
    params.require(:videgame).permit(:name, :description, :rating, :price)
  end
end
