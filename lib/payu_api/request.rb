module PayuAPI
  class Request
    API_URL = 'https://secure.payu.com/'.freeze
    API_SANDBOX_URL = 'https://secure.snd.payu.com/'.freeze

    # rubocop:disable Metrics/AbcSize
    def call
      connection = Faraday::Connection.new(api_url)
      connection.public_send(method.to_s.downcase) do |request|
        request.url url
        request.body = body if body
        headers.each do |key, value|
          request.headers[key] = value
        end
      end
    rescue Faraday::Error => e
      raise RequestError, e.message
    end

    private

    def api_url
      sandbox? ? API_SANDBOX_URL : API_URL
    end

    def sandbox?
      raise NotImplementedError
    end

    def method
      raise NotImplementedError
    end

    def url
      raise NotImplementedError
    end

    def headers
      {}
    end

    def body
      nil
    end
  end
end
