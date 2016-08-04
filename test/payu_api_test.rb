require 'test_helper'

class PayuApiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PayuAPI::VERSION
  end
end
