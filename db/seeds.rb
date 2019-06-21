# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


1.times do
  Location.create!(
    name: "Somerset West",
    display_in_navbar: 1
  )
end

1.times do
  User.create!(
    username: "pdivvie",
    email: "pdivvie@outlook.com",
    first_name: "Pierre",
    last_name: "de Villiers",
    password: "password",
    location_id: 1
  )
end

1.times do
  Category.create!(
    name: "Dentist",
  )
end

9.times do |business_item|
  Business.create!(
    name: "Business: #{business_item}",
    body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    user_id: 1,
    category_id: 1,
    location_id: 1
  )

end