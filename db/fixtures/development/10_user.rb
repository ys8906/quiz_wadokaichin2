# frozen_string_literal: true

require 'csv'
file_path = 'db/fixtures/development/10_user.csv'

# First user
CSV.foreach(file_path, headers: true) do |row|
  User.seed do |u|
    u.id        = row['id']
    u.name      = row['name']
    u.email     = row['email']
    u.password  = row['password']
  end
end

# Others
5.times do |i|
  User.seed do |u|
    u.id        = i + 2
    u.name      = Faker::Name.name
    u.email     = Faker::Internet.email
    u.password  = 'password'
  end
end
