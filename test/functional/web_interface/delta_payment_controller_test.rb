require 'test_helper'

class WebInterface::DeltaPaymentControllerTest < ActionController::TestCase
  test "should get pay" do
    get :pay
    assert_response :success
  end

end
