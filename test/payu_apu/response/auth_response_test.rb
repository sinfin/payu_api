require 'test_helper'

class PayuAPI::AuthResponseTest < Minitest::Test
  def test_success_response
    http_response = Minitest::Mock.new
    http_response.expect :status, 200
    http_response.expect :body, '{"access_token":"12345","expires_in":100}'

    response = PayuAPI::AuthResponse.new(http_response: http_response)

    assert_equal true, response.success?
    assert_equal '12345', response.auth_token
    assert_equal 100, response.expires_in
  end

  def test_error_response
    http_response = Minitest::Mock.new
    http_response.expect :status, 403
    http_response.expect :body, '{"error":"ACCESS_DENIED", "error_description": "Access denied"}'

    response = PayuAPI::AuthResponse.new(http_response: http_response)

    assert_equal false, response.success?
    assert_nil response.auth_token
    assert_nil response.expires_in
  end
end
