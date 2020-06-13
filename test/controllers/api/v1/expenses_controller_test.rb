require 'test_helper'

class Api::V1::ExpensesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @expense = expenses(:one)
  end

  test "should get expenses data" do
    get api_v1_expenses_url
    assert_response :success
  end

  test "should create an expense" do
    assert_difference('Expense.count') do
      post api_v1_expenses_url, params: {   type: @expense.type, 
                                            date: @expense.date, 
                                            concept: @expense.concept, 
                                            category: @expense.category, 
                                            amount: @expense.amount }
    end
    assert_response :success
  end

  test "should update an expense" do
    patch "/api/v1/expenses/1",  params: {  type: @expense.type, 
                                            date: @expense.date, 
                                            concept: @expense.concept, 
                                            category: @expense.category, 
                                            amount: @expense.amount  }
    assert_response :success
  end

  test "should get destroy" do
    delete "/api/v1/expenses/1"
    assert_response :success
  end

end
