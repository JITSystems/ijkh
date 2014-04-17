require 'test_helper'

class WebMoneyControllerTest < ActionController::TestCase
  test "should get payment_notification" do
    get :payment_notification
    assert_response :success
  end

  test "should get invoice_confirmation" do
    get :invoice_confirmation
    assert_response :success
  end

end
