class PagesController < ApplicationController
  def home
    @videogames = Videogame.all
  end
end
