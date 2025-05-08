class VideogamesController < ApplicationController

  def my_videogames
    @my_videogames = current_user.videogames

    @pending_requests_count = @my_videogames.sum do |videogame|
      videogame.bookings.where(status: "pending").count
    end
  end


  def index
    @videogames = Videogame.all

    if params[:query].present?
      sql_subquery = "name ILIKE :query OR description ILIKE :query"
      @videogames = @videogames.where(sql_subquery, query: "%#{params[:query]}%")
    end

    if params[:category].present? && params[:category] != "All"
      @videogames = @videogames.where(category: params[:category])
    end

    if params[:platform].present? && params[:platform] != "All"
      @videogames = @videogames.where(platform: params[:platform])
    end

    if params[:max_price].present?
      @videogames = @videogames.where("price <= ?", params[:max_price].to_f)
    end

    if params[:min_rating].present?
      @videogames = @videogames.where("rating >= ?", params[:min_rating].to_i)
    end
  end

  def new
    @videogame = Videogame.new
  end

  def create
    @videogame = Videogame.new(videogame_params)
    @videogame.owner = current_user

    if @videogame.save
      redirect_to root_path, notice: "Game successfully added ! 🎮"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @videogame = Videogame.find(params[:id])
  end

  def edit
    @videogame = Videogame.find(params[:id])
  end

  def update
    @videogame = Videogame.find(params[:id])
    @videogame.update(videogame_params)
    redirect_to videogame_path(@videogame)
  end

  def destroy
    @videogame = Videogame.find(params[:id])
    if @videogame.owner == current_user
      @videogame.destroy
      redirect_to my_videogames_path, notice: "	Game successfully deleted ! 🎮"
    else
      redirect_to root_path, alert: "You don't have permission to delete this game."
    end
  end

  private

  def videogame_params
    params.require(:videogame).permit(:name, :description, :rating, :price, :category, :platform, :background_image, :photo)
  end
end
