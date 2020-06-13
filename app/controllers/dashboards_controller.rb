class DashboardsController < ApplicationController
  def index
    @tab = :dashboard
    @expenses = Expense.all.order(date: :desc)

    # Chartkick column chart, data order by month - Multiple series
    @column_data =
      Expense.types.keys.map do |type|
        {
          name: type.capitalize,
          data: @expenses.where(type: type).group_by_month(:date, last: 6).unscope(:order).sum(:amount)
        }
      end

    # Chartkick column chart, data order by day of current Month - Multiple series
    @day_data =
      Expense.types.keys.map do |type|
        {
          name: type.capitalize,
          data:
            @expenses.where(type: type).group_by_day_of_month(
              :date,
              range: Date.current.beginning_of_month..Date.current.end_of_month,
              series: false
            ).unscope(:order).sum(:amount)
        }
      end

    # Start logic to load pie chart
    # Load categories expenses
    categories = load_filter_expenses(@expenses, 'category')
    # Load Pie chart Labels in array
    filter_categories = []
    # Populate data uin array
    categories.each do |key, category|
      item =
        @expenses.where(
          'category == :category AND date >= :start_date AND date <= :end_date',
          {
            category: category,
            start_date: Date.current.beginning_of_month,
            end_date: Date.current.end_of_month
          }
        ).count
      filter_categories << category if item > 0
    end

    # Chartkick Pie chart, data order by current month expense categories - Single series
    @category_data =
      filter_categories.map do |category|
        [
          category.capitalize,
          @expenses.where(
            'category == :category AND date >= :start_date AND date <= :end_date',
            {
              category: category,
              start_date: Date.current.beginning_of_month,
              end_date: Date.current.end_of_month
            }
          ).sum(:amount)
        ]
      end

    # Chartkick Bar chart, data order by previous month and current month expenses - Multiple series
    dates = [Date.current.prev_month, Date.current]

    @acumulated_data =
      dates.map do |date|
        [
          Date::ABBR_MONTHNAMES[date.month],
          @expenses.where(
            'date >= :start_date AND date <= :end_date',
            { start_date: date.beginning_of_month, end_date: date.end_of_month }
          ).sum(:amount)
        ]
      end

    # Array to load random colors for pie chart categories
    @colors = Array.new
    # Populate array
    categories.count.times { |x| @colors.push(generate_random_color) }
  end
end
