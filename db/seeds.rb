require 'faker'
require 'httparty'

puts "Starting seeding Videogames..."

# API Key
api_key = '1f633aa6fea946c7b3b386105279fd17'

user = User.first_or_create!(
  first_name: "Default",
  last_name: "Admin",
  email: "admin@example.com",
  password: "password",
  phone_number: "1234567890"
)

url = "https://api.rawg.io/api/games?key=#{api_key}&page=1&page_size=10"
response = HTTParty.get(url)

games = response.parsed_response['results']

games.each do |game_data|
  game_name = game_data['name']
  game_rating = game_data['rating'] || 5.0
  game_description = "No description available"
  game_background = game_data['background_image'] || "https://example.com/default-poster.jpg"

  genre = if game_data['genres'] && game_data['genres'].first
            game_data['genres'].first['name']
          else
            "Action"
          end

  category = Videogame::CATEGORIES.include?(genre) ? genre : "Action"

  platform_name = if game_data['platforms'] && game_data['platforms'].first
                    game_data['platforms'].first['platform']['name']
                  else
                    "Unknown"
                  end

  price = Faker::Number.between(from: 5.0, to: 20.0).round(2)

  # Create videogame record
  Videogame.create!(
    name: game_name,
    description: game_description,
    rating: game_rating,
    category: category,
    background_image: game_background,
    platform: platform_name,
    price: price
  )
end

puts "Seeding completed successfully!"
