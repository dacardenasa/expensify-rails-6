class AddExpTypeToExpenses < ActiveRecord::Migration[6.0]
  def change
    add_column :expenses, :exp_type, :string
  end
end
