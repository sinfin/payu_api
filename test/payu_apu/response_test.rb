require 'test_helper'

class PayuAPI::ResponseTest < Minitest::Test
  def test_success_response
    http_response = Minitest::Mock.new
    http_response.expect :status, 200
    http_response.expect :body, '{"status":{"statusCode":"SUCCESS","statusDesc":"Success"}}'

    response = PayuAPI::Response.new(http_response: http_response)

    assert_equal true, response.success?
    assert_equal false, response.error?
    assert_nil response.error_code
    assert_nil response.error_message
  end

  def test_error_response_with_status
    http_response = Minitest::Mock.new
    http_response.expect :status, 404
    http_response.expect :body, '{"status":{"statusCode":"NOT_FOUND","statusDesc": "Not found"}}'

    response = PayuAPI::Response.new(http_response: http_response)

    assert_equal false, response.success?
    assert_equal true, response.error?
    assert_equal 'NOT_FOUND', response.error_code
    assert_equal 'Not found', response.error_message
  end

  def test_error_response_without_status
    http_response = Minitest::Mock.new
    http_response.expect :status, 403
    http_response.expect :body, '{"error":"ACCESS_DENIED", "error_description": "Access denied"}'

    response = PayuAPI::Response.new(http_response: http_response)

    assert_equal false, response.success?
    assert_equal true, response.error?
    assert_equal 'ACCESS_DENIED', response.error_code
    assert_equal 'Access denied', response.error_message
  end

  def test_invalid_response
    http_response = Minitest::Mock.new
    http_response.expect :status, 200
    http_response.expect :body, 'invalid_json'

    response = PayuAPI::Response.new(http_response: http_response)

    assert_raises(PayuAPI::InvalidResponseError) { response.success? }
  end
end
