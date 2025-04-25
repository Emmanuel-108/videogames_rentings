class CreateVideogames < ActiveRecord::Migration[7.1]
  def change
    create_table :videogames do |t|
      t.string :name
      t.text :description
      t.integer :rating
      t.decimal :price

      t.timestamps
    end
  end
end
