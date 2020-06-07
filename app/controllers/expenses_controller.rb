class ExpensesController < ApplicationController

  def index
    @tab = :expenses
    @expenses = Expense.all.order(date: :desc)
    @types = load_filter_expenses( @expenses, "type" )
    @categories = load_filter_expenses( @expenses, "category")
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.create(params_expense)
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id]).update!(params_expense)
  end

  def destroy
    @id = params[:id].to_i
    expense = Expense.find(@id)
    expense.destroy
  end

  private
  def params_expense
    params.require(:expense).permit(:type, :date, :concept, :category, :account)
  end

end
