require 'test_helper'

class Handling404ApplicationControllerTest < ActionDispatch::IntegrationTest

  # A test to make sure the application controller is handling 
  # 404 errors in a reasonable manner.

  test "a 404 error is adequately handled by the system." do
    login_as(:customer)
    get item_path(999)
    assert_equal "We apologize, but this information could not be found.", flash[:error]
    assert_redirected_to error_404_path
  end

end