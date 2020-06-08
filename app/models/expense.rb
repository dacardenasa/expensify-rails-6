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
#  type       :integer
#
class Expense < ApplicationRecord
  self.inheritance_column = nil
  enum type: [:Purchase, :Withdrawal, :Transfer, :Payment]

  validates :date, :concept, :amount, :category, :type, presence: { message: "Field Required" }
  validates_length_of :concept, minimum: 3, too_short: "Enter at least 3 characters"
  validates_numericality_of :amount, greater_than: 0

end
