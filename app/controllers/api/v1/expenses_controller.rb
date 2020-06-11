class Api::V1::ExpensesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    expenses = Expense.all
    render json: expenses, status: 200
  end

  def create
    expense = Expense.create(params_expense)
    if expense.save
      render json: expense, status: 201
    else
      render json: { errors: expense.errors }, status: 422
    end
  end

  def update
    expense = Expense.find(params[:id])
    if expense.update(params_expense)
      render json: expense, status: 200
    else
      render json: { errors: expense.errors }, status: 422
    end
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy
    render json: expense, status: 204
  end

  private
  def params_expense
    params.permit(:type, :date, :concept, :category, :amount)
  end

end
