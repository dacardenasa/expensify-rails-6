class ChangeColumnInTable < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :expenses do |t|
        dir.up   { t.change :exp_type, :integer }
        dir.down { t.change :exp_type, :string }
      end
    end
  end
end
