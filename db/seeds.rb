require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


type = [ "Purchase", "Withdrawal", "Transfer", "Payment" ]

180.times do | x |
  Expense.create(
                 date: Faker::Date.in_date_period(month: rand(1..6)),
                 concept: "This is the transaction #{ x }",
                 category: Faker::Commerce.department(max: 1),
                 amount: Faker::Commerce.price(range: 1..2000.0, as_string: true),
                 exp_type: type[rand(0..3)]
                 )
end