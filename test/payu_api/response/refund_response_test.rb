require 'test_helper'

class PayuAPI::RefundResponseTest < Minitest::Test
  def test_success_response
    http_response = Minitest::Mock.new
    http_response.expect :status, 200
    http_response.expect :body, '{"status":{"statusCode":"SUCCESS"},"refund":{"id":"10"}}'

    response = PayuAPI::RefundResponse.new(http_response: http_response)

    assert_equal true, response.success?
    assert_equal '10', response.refund[:id]
  end
end
