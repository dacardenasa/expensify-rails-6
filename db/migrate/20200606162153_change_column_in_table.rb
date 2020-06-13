class ChangeColumnInTable < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :expenses do |t|
        dir.up   { t.change :type, 'integer USING CAST(type AS integer)' }
        dir.down { t.change :type, :string }
      end
    end
  end
end
