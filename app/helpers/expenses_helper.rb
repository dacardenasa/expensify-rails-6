module ExpensesHelper

  def form_title
    @expense.new_record? ? "Add Expense" : "Edit Expense"
  end

end
