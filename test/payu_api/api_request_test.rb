require 'test_helper'

class PayuAPI::ApiRequestTest < Minitest::Test
  def test_it_makes_http_request
    stub_request(:post, 'https://secure.payu.com/make/action')
      .with(
        body: '{"p1":1,"p2":2}',
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => 'Bearer abcdef'
        }
      )
      .to_return(status: 200, body: '{"status":"SUCCESS"}')

    client = Minitest::Mock.new
    client.expect :sandbox, false
    client.expect :auth_token, 'abcdef'
    client.expect :logger, nil

    params = { p1: 1, p2: 2 }
    request = PayuAPI::ApiRequest.new(client, :POST, '/make/action', params)
    response = request.call

    assert_equal 200, response.status
    assert_equal '{"status":"SUCCESS"}', response.body
  end

  def test_it_raise_error_when_timeout
    stub_request(:post, 'https://secure.payu.com/make/action')
      .with(
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => 'Bearer abcdef'
        }
      )
      .to_timeout

    client = Minitest::Mock.new
    client.expect :sandbox, false
    client.expect :auth_token, 'abcdef'
    client.expect :logger, nil

    request = PayuAPI::ApiRequest.new(client, :POST, '/make/action')

    assert_raises(PayuAPI::RequestError) { request.call }
  end

  def test_it_use_sandbox_url
    stub_request(:post, 'https://secure.snd.payu.com/make/action')
      .with(
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => 'Bearer abcdef'
        }
      )
      .to_return(status: 404, body: '{"status":"NOT_FOUND"}')

    client = Minitest::Mock.new
    client.expect :sandbox, true
    client.expect :auth_token, 'abcdef'
    client.expect :logger, nil

    request = PayuAPI::ApiRequest.new(client, :POST, '/make/action')
    response = request.call

    assert_equal 404, response.status
    assert_equal '{"status":"NOT_FOUND"}', response.body
  end
end
