require 'test_helper'

class ExpenseFlowTest < ActionDispatch::IntegrationTest

  test 'Should load filters flow' do
    Capybara.current_driver = Capybara.javascript_driver
    visit expenses_path
    click_on('Payment')
    click_on('ok')
    click_on('Purchase')
    click_on('ok')
    click_on('Withdrawal')
    click_on('ok')
    click_on('Beauty')
    click_on('ok')
  end
  
end
