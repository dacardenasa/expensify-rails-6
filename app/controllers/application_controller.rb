class ApplicationController < ActionController::Base
  # Method to load types && categories
  def load_filter_expenses(data, filter)
    load_filter = Hash.new
    data.each do |d|
      if filter == 'type'
        load_filter[d.type] = d.type
      else
        load_filter[d.category] = d.category
      end
    end
    load_filter.sort
  end

  # Method to generate random colors
  def generate_random_color
    "rgb(#{rand(0..255)}, #{rand(0..255)}, #{rand(0..255)})"
  end
end
