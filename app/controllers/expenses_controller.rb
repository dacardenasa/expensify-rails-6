class ExpensesController < ApplicationController

  def index
    @tab = :expenses
    @expenses =
      Expense.where(
        'date >= :start_date AND date <= :end_date',
        {
          start_date: Date.current.beginning_of_month,
          end_date: Date.current.end_of_month
        }
      ).order(date: :desc)
    @types = load_filter_expenses(Expense.all, 'type')
    @categories = load_filter_expenses(Expense.all, 'category')
  end

  def new
    @expense = Expense.new
    @types = load_filter_expenses(Expense.all, 'type')
    @categories = load_filter_expenses(Expense.all, 'category')
  end

  def create
    @expense = Expense.create(params_expense)
  end

  def show
    @expense = Expense.find(params[:id])
    @types = load_filter_expenses(Expense.all, 'type')
    @categories = load_filter_expenses(Expense.all, 'category')
  end

  def update
    @prev_expense = Expense.find(params[:id])
    @expense = Expense.find(params[:id])
    @expense.update(params_expense)
  end

  def destroy
    @expense = Expense.find(params[:id])
    Expense.find(params[:id]).destroy
  end

  def filter
    @expenses = Expense.all

    if params[:type].present?
      @filter = params[:type]
      @expenses =
        @expenses.where('type = :filter', { filter: Expense.types[@filter] }).order(
          date: :desc
        )
    end

    if params[:category].present?
      @filter = params[:category]
      @expenses =
        @expenses.where('category = :filter', { filter: @filter }).order(
          date: :desc
        )
    end

    if params[:date].present?
      @filter = Date.parse(params[:date])
      @expenses =
        @expenses.where(
          'date >= :start_date AND date <= :end_date',
          {
            start_date: @filter.beginning_of_month,
            end_date: @filter.end_of_month
          }
        ).order(date: :desc)
    end

  end

  private
  def params_expense
    params.require(:expense).permit(:type, :date, :concept, :category, :amount)
  end

end
