class DashboardsController < ApplicationController
  def index
    @tab = :dashboard
    @expenses = Expense.all.order(date: :desc)

    # Column chart data order by month
    @column_data = Expense.types.keys.map do | type |
      { name: type.capitalize, data: @expenses.where(type: type).group_by_month(:date).sum(:amount) }
    end

    # Column chart data order by day of current month
    @day_data = Expense.types.keys.map do | type |
      { name: type.capitalize, 
        data: @expenses.where(type: type).
        group_by_day_of_month(:date, range: Date.current.beginning_of_month..Date.current.end_of_month, series: false).
        sum(:amount) }
    end

    # Pie chart data order by current month categories
    categories = load_filter_expenses( @expenses, "category" )
    
    filter_categories = []
    categories.each do | key, category |
      item = @expenses.where('category == :category AND date >= :start_date AND date <= :end_date',
                              {
                                category: category,
                                start_date: Date.current.beginning_of_month, 
                                end_date: Date.current.end_of_month
                              }).count()
      filter_categories << category if item > 0 
    end

    @category_data = filter_categories.map do | category |
        [ category.capitalize,
          @expenses.where( "category == :category AND date >= :start_date AND date <= :end_date", 
            { 
              category: category,
              start_date: Date.current.beginning_of_month, 
              end_date: Date.current.end_of_month
            }).sum(:amount)
        ]
    end

    # Bar chart data order by previos month and current month expenses
    dates = [ Date.current.prev_month, Date.current  ]
    
    @acumulated_data = dates.map do | date |
      [ 
        Date::ABBR_MONTHNAMES[date.month], 
        @expenses.where("date >= :start_date AND date <= :end_date",{
          start_date: date.beginning_of_month,
          end_date: date.end_of_month
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

