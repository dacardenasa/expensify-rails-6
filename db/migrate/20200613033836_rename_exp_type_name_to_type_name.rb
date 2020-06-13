class RenameExpTypeNameToTypeName < ActiveRecord::Migration[6.0]
  def change
    def change
      rename_column :expenses, :exp_type, :type
    end
  end
end
