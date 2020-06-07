class DashboardsController < ApplicationController
  def index
    @tab = :dashboard
    @expenses = Expense.all.order(date: :desc)
    @column_data = Expense.types.keys.map do | type |
      { name: type.capitalize, data: Expense.where(type: type).group_by_week(:date).sum(:amount) }
    end

    @category_colors = []
    filter_data = load_filter_expenses( @expenses, "category" )

    filter_data.count().times do | x | 
      @category_colors.push(generate_random_color)
    end
    
  end
end