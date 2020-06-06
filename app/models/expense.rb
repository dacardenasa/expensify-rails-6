# == Schema Information
#
# Table name: expenses
#
#  id         :integer          not null, primary key
#  date       :date
#  concept    :text
#  category   :string
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  exp_type   :string
#
class Expense < ApplicationRecord
end
