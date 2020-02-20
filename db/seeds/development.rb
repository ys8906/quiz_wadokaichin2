# First user
require "csv"
CSV.foreach('db/seeds/development.csv', headers: true) do |row|
  User.seed do |u|
    u.id        = row['id']
    u.name      = row['name']
    u.email     = row['email']
    u.password  = row['password']
  end
end

# Users after second
5.times do |i|
  User.seed do |u|
    u.id        = i + 2
    u.name      = Faker::Name.name
    u.email     = Faker::Internet.email
    u.password  = "password"
  end
end
