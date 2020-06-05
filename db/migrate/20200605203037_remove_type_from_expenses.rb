class RemoveTypeFromExpenses < ActiveRecord::Migration[6.0]
  def change

    remove_column :expenses, :type, :string
  end
end
