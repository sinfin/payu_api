require 'test_helper'

class PayuAPI::BuildSignatureTest < Minitest::Test
  def test_it_build_signature
    signature = PayuAPI::BuildSignature.new(body: 'body', second_key: 'key').call

    expected = 'sender=checkout;signature=88ba13d194d0af078007ea9fa9a1ffc2;algorithm=MD5;content=DOCUMENT'
    assert_equal expected, signature
  end
end
