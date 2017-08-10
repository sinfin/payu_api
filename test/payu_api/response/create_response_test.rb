require 'test_helper'

class PayuAPI::CreateResponseTest < Minitest::Test
  def test_response_200
    http_response = Minitest::Mock.new
    http_response.expect :status, 200
    body = '{"status":{"statusCode":"SUCCESS"},"orderId":"10","redirectUri":"http://example.com/"}'
    http_response.expect :body, body

    response = PayuAPI::CreateResponse.new(http_response: http_response)

    assert_equal true, response.success?
    assert_equal '10', response.order_id
    assert_equal 'http://example.com/', response.redirect_uri
  end

  def test_response_302
    http_response = Minitest::Mock.new
    http_response.expect :status, 302
    body = '{"status":{"statusCode":"WARNING_CONTINUE_CVV"},"orderId":"10","redirectUri":"http://example.com/"}'
    http_response.expect :body, body

    response = PayuAPI::CreateResponse.new(http_response: http_response)

    assert_equal true, response.success?
    assert_equal '10', response.order_id
    assert_equal 'http://example.com/', response.redirect_uri
  end
end
