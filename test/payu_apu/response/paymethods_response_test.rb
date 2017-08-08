require 'test_helper'

class PayuAPI::PaymethodsResponseTest < Minitest::Test
  def test_empty_results
    http_response = Minitest::Mock.new
    http_response.expect :status, 200
    http_response.expect :body, '{"status":{"statusCode":"SUCCESS"}}'

    response = PayuAPI::PaymethodsResponse.new(http_response: http_response)

    assert_equal true, response.success?
    assert_equal false, response.error?
    assert_equal [], response.pay_by_links
    assert_equal [], response.pex_tokens
    assert_equal [], response.card_tokens
    assert_nil response.error_code
    assert_nil response.error_message
  end

  def test_not_empty_pay_by_links_response
    http_response = Minitest::Mock.new
    http_response.expect :status, 200
    http_response.expect :body, '{"payByLinks":[{"value":"m","brandImageUrl":"https://static.payu.com/images/mobile/logos/pbl_m.png","name":"mTransfer","status":"ENABLED"}, {"value":"o","brandImageUrl":"https://static.payu.com/images/mobile/logos/pbl_o.png","name":"Płacę z Bankiem Pekao S.A.","status":"ENABLED"}, {"value":"p","brandImageUrl":"https://static.payu.com/images/mobile/logos/pbl_p.png","name":"Płacę z iPKO","status":"ENABLED"}, {"value":"c","brandImageUrl":"https://static.payu.com/images/mobile/logos/pbl_c.png","name":"Płatność online kartą płatniczą","status":"ENABLED"}],"status":{"statusCode":"SUCCESS"}}'

    response = PayuAPI::PaymethodsResponse.new(http_response: http_response)

    assert_equal true, response.success?
    assert_equal false, response.error?
    assert_equal [{:value=>"m", :brandImageUrl=>"https://static.payu.com/images/mobile/logos/pbl_m.png", :name=>"mTransfer", :status=>"ENABLED"}, {:value=>"o", :brandImageUrl=>"https://static.payu.com/images/mobile/logos/pbl_o.png", :name=>"Płacę z Bankiem Pekao S.A.", :status=>"ENABLED"}, {:value=>"p", :brandImageUrl=>"https://static.payu.com/images/mobile/logos/pbl_p.png", :name=>"Płacę z iPKO", :status=>"ENABLED"}, {:value=>"c", :brandImageUrl=>"https://static.payu.com/images/mobile/logos/pbl_c.png", :name=>"Płatność online kartą płatniczą", :status=>"ENABLED"}], response.pay_by_links
    assert_equal [], response.pex_tokens
    assert_equal [], response.card_tokens
    assert_nil response.error_code
    assert_nil response.error_message
  end
end
