module PayuAPI
  class Paymethods
    class << self
      def get(client:)
        request = ApiRequest.new(client, :GET, "/api/v2_1/paymethods")
        PaymethodsResponse.new(http_response: request.call)
      end
    end
  end
end
