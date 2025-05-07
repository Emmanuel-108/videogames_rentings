require 'faker'
require 'httparty'

puts "Starting seeding Videogames..."

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
  game_id = game_data['id']
  detail_url = "https://api.rawg.io/api/games/#{game_id}?key=#{api_key}"
  detail_response = HTTParty.get(detail_url)
  game_description = detail_response.parsed_response['description_raw'] || "No description available"

  game_name = game_data['name']
  game_rating = game_data['rating'] || 5.0
  game_background = game_data['background_image'] || "https://example.com/default-poster.jpg"

  genre = game_data.dig('genres', 0, 'name') || "Action"
  category = Videogame::CATEGORIES.include?(genre) ? genre : "Action"

  platform_name = game_data.dig('platforms', 0, 'platform', 'name') || "Unknown"
  price = Faker::Number.between(from: 5.0, to: 20.0).round(2)

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
