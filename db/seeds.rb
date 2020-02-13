users = ["Jane", "John", "Bob", "Alice", "Michael"]
users.each_with_index do |user, i|
  User.create(
    name: "#{user}",
    email: "#{i + 1}@example.com",
    password: "password"
  )
end