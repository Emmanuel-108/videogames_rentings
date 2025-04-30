require "test_helper"

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get checkout_show_url
    assert_response :success
  end

  test "should get confirm_payment" do
    get checkout_confirm_payment_url
    assert_response :success
  end
end
