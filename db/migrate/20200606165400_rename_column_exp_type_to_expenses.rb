class RenameColumnExpTypeToExpenses < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :expenses do |t|
        dir.up   { t.rename :exp_type, :type }
        dir.down { t.rename :exp_type, :exp_type }
      end
    end
  end
end
