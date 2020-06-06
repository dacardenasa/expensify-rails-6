class ExpensesController < ApplicationController

  def index
    @expenses = Expense.all.order(date: :desc)
    @types = Hash.new
    @categories = Hash.new

    @expenses.each do | x |

      if( !@categories.has_key?("#{ x.category }") )
        @categories["#{ x.category }"] = x.category
      end

      if( !@types.has_key?("#{ x.exp_type }") )
        @types["#{ x.exp_type }"] = x.exp_type
      end
      
    end
  end

  def new
    @expense = Expense.new
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def destroy
    expense = Expense.find(params[:id]).destroy
  end

  private
  def params_expense
    params.require(:expense).permit(:exp_type, :date, :concept, :category, :account)
  end

end
