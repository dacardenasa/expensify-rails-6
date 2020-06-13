# == Schema Information
#
# Table name: expenses
#
#  id         :integer          not null, primary key
#  date       :date
#  concept    :text
#  category   :string
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :integer
#
require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase

  test "Should not save expense without data" do
    expense = Expense.new
    assert_not expense.save
  end

  test "Should not save expense with letters in amount" do
    expense = Expense.new(date: "2020-06-10",
                          concept: "Payment Rafa",
                          category: "Beauty",
                          amount: "asd",
                          type: "Payment")
    assert_not expense.save
  end

  test "Should not save expense with min-length < 3 in concept" do
    expense = Expense.new(date: "2020-06-10",
                          concept: "a",
                          category: "Beauty",
                          amount: 200,
                          type: "Payment")
    assert_not expense.save
  end

  test "Should not save expense with amount = 0" do
    expense = Expense.new(date: "2020-06-10",
                          concept: "a",
                          category: "Beauty",
                          amount: 0,
                          type: "Payment")
    assert_not expense.save
  end

end
