module PayuAPI
  class Paymethods
    class << self
      def get(client:, lang: nil)
        path = "/api/v2_1/paymethods"
        path += "?lang=#{lang}" if lang

        request = ApiRequest.new(client, :GET, path)
        PaymethodsResponse.new(http_response: request.call)
      end
    end
  end
end
