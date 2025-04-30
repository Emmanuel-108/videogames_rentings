class PagesController < ApplicationController
  def home
    @videogames = Videogame.all
  end

  def contact
  end
end
