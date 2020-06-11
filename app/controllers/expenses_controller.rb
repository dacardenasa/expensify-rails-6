class ExpensesController < ApplicationController

  def index
    @tab = :expenses
    @expenses = Expense.where("date >= :start_date AND date <= :end_date", {
                              start_date: Date.current.beginning_of_month,
                              end_date: Date.current.end_of_month
                              }).order(date: :desc)
    @types = load_filter_expenses( Expense.all, "type" )
    @categories = load_filter_expenses( Expense.all, "category")
  end

  def new
    @expense = Expense.new
    @categories = load_filter_expenses( Expense.all, "category")
    @types = load_filter_expenses( Expense.all, "type")
  end

  def create
    @expense = Expense.create(params_expense)
  end

  def show
    @expense = Expense.find(params[:id])
    @categories = load_filter_expenses( Expense.all, "category")
    @types = load_filter_expenses( Expense.all, "type")
  end

  def update
    @expense = Expense.find(params[:id])
    @prev_expense = Expense.find(params[:id])
    @expense.update(params_expense)
  end

  def destroy
    @expense = Expense.find(params[:id])
    Expense.find(params[:id]).destroy
  end

  def filter
    @filter = params[:value]
    if Expense.types.keys.include?(@filter)
      Expense.types.keys.each_with_index do |key, indice|
        if key == @filter
          @type_index = indice
        end
      end
      @expenses = Expense.where("type == :filter", { filter: @type_index }).order(date: :desc)
    # Here I go, validate month and filter by its, after that make the logic of view for this filter
    elsif Date::MONTHNAMES.include?(@filter)
      @month = @filter
      @expenses = Expense.where("date >= :start_date AND date <= :end_date",
                                { 
                                  start_date: Date.parse(@filter).beginning_of_month,
                                  end_date: Date.parse(@filter).end_of_month
                                }
                              ).order(date: :desc)
    else
      @expenses = Expense.where("category == :filter", { filter: @filter }).order(date: :desc)
    end
  end

  private
  def params_expense
    params.require(:expense).permit(:type, :date, :concept, :category, :amount)
  end

end
