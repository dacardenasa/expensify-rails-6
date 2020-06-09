class ExpensesController < ApplicationController

  def index
    @tab = :expenses
    @expenses = Expense.all.order(date: :desc)
    @types = load_filter_expenses( @expenses, "type" )
    @categories = load_filter_expenses( @expenses, "category")
  end

  def new
    respond_to do |format|
      format.html
      format.js
    end
    @expense = Expense.new
    @categories = load_filter_expenses( Expense.all, "category")
  end

  def create
    @expense = Expense.create(params_expense)
  end

  def show
    @expense = Expense.find(params[:id])
    @categories = load_filter_expenses( Expense.all, "category")
  end

  def update
    @expense = Expense.find(params[:id])
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
    else
      @expenses = Expense.where("category == :filter", { filter: @filter }).order(date: :desc)
    end

  end

  private
  def params_expense
    params.require(:expense).permit(:type, :date, :concept, :category, :amount)
  end

end
