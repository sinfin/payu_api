require 'test_helper'

class PayuAPI::AuthRequestTest < Minitest::Test
  def test_it_makes_http_request
    stub_request(:post, 'https://secure.payu.com/pl/standard/user/oauth/authorize')
      .with(
        body: 'grant_type=client_credentials&client_id=10&client_secret=absdef',
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
      )
      .to_return(status: 200, body: '{"status":"SUCCESS"}')

    request = PayuAPI::AuthRequest.new(pos_id: 10, key: 'absdef')
    response = request.call

    assert_equal 200, response.status
    assert_equal '{"status":"SUCCESS"}', response.body
  end

  def test_it_raise_error_when_timeout
    stub_request(:post, 'https://secure.payu.com/pl/standard/user/oauth/authorize')
      .with(
        body: 'grant_type=client_credentials&client_id=10&client_secret=absdef',
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
      )
      .to_timeout

    request = PayuAPI::AuthRequest.new(pos_id: 10, key: 'absdef')

    assert_raises(PayuAPI::RequestError) { request.call }
  end

  def test_it_use_sandbox_url
    stub_request(:post, 'https://secure.snd.payu.com/pl/standard/user/oauth/authorize')
      .with(
        body: 'grant_type=client_credentials&client_id=10&client_secret=absdef',
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
      )
      .to_return(status: 403, body: '{"status":"ERROR"}')

    request = PayuAPI::AuthRequest.new(pos_id: 10, key: 'absdef', sandbox: true)
    response = request.call

    assert_equal 403, response.status
    assert_equal '{"status":"ERROR"}', response.body
  end
end
