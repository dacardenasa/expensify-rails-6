require 'test_helper'

class ExpensesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @expense = expenses(:one)
  end

  test "Should create an expense" do
    assert_difference "Expense.count" do
      post expenses_url, params: { expense: { 
                                              date: @expense.date,
                                              concept: @expense.concept,
                                              category: @expense.category,
                                              amount: @expense.amount,
                                              type: @expense.type
                                              }}, xhr: true
    end
    assert_not_nil assigns(:expense)
    assert_template "create"
  end

end
