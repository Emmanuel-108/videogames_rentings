class AddColumnsCategoryImagePlatform < ActiveRecord::Migration[7.1]
  def change
    add_column :videogames, :category, :string
    add_column :videogames, :background_image, :text
    add_column :videogames, :platform, :string
  end
end
