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
    $date_format = /(\d{4}\-\d{1,2}\-\d{1,2})/

    if Expense.types.keys.include?(params[:value])
      @filter = params[:value]
      @expenses =
        Expense.where('type = :filter', { filter: Expense.types[@filter] }).order(
          date: :desc
        )
        
    elsif params[:value].match($date_format)
      @filter = Date.parse(params[:value])
      
      @expenses =
        Expense.where(
          'date >= :start_date AND date <= :end_date',
          {
            start_date: @filter.beginning_of_month,
            end_date: @filter.end_of_month
          }
        ).order(date: :desc)

    else
      @filter = params[:value]
      @expenses =
        Expense.where('category = :filter', { filter: @filter }).order(
          date: :desc
        )
    end
  end

  private
  def params_expense
    params.require(:expense).permit(:type, :date, :concept, :category, :amount)
  end

end
