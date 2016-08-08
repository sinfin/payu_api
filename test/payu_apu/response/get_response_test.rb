require 'test_helper'

class PayuAPI::CreateResponseTest < Minitest::Test
  def test_success_response
    http_response = Minitest::Mock.new
    http_response.expect :status, 200
    http_response.expect :body, '{"status":{"statusCode":"SUCCESS"},"orders":[{"id":"10"}]}'

    response = PayuAPI::GetResponse.new(http_response: http_response)

    assert_equal true, response.success?
    assert_equal '10', response.order[:id]
  end
end
