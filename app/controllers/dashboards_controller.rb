class DashboardsController < ApplicationController
  def index
    @tab = :dashboard
    @expenses = Expense.all.order(date: :desc)

    @column_data = Expense.types.keys.map do | type |
      { name: type.capitalize, data: Expense.where(type: type).group_by_week(:date).sum(:amount) }
    end

    @day_data = Expense.types.keys.map do | type |
      { name: type.capitalize, 
        data: Expense.where(type: type).
        group_by_day(:date, range: Date.current.beginning_of_month..Date.current.end_of_month).
        sum(:amount) }
    end

    categories = load_filter_expenses( @expenses, "category" )

    @category_data = categories.map do | key, category |
        [ category.capitalize,
          Expense.where("category == :category AND date >= :start_date AND date <= :end_date", 
            { 
              category: category,
              start_date: Date.current.beginning_of_month, 
              end_date: Date.current.end_of_month 
            }).sum(:amount)
        ]
    end 

    @category_colors = []
    filter_data = load_filter_expenses( @expenses, "category" )

    filter_data.count().times do | x | 
      @category_colors.push(generate_random_color)
    end
    
  end
end

