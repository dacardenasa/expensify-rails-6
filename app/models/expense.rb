# == Schema Information
#
# Table name: expenses
#
#  id         :integer          not null, primary key
#  type       :string
#  date       :date
#  concept    :text
#  category   :string
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Expense < ApplicationRecord
end
