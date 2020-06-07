require 'faker'

180.times do | x |
  Expense.create(
                 date: Faker::Date.in_date_period(month: rand(1..6)),
                 concept: "This is the transaction #{ x }",
                 category: Faker::Commerce.department(max: 1),
                 amount: Faker::Commerce.price(range: 1..2000.0, as_string: true),
                 type: Expense.types.keys.sample
                 )
end