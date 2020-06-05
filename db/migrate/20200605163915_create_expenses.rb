class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.string :type
      t.date :date
      t.text :concept
      t.string :category
      t.integer :amount

      t.timestamps
    end
  end
end
