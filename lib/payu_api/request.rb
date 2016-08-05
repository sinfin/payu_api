module PayuAPI
  class Request
    extend Dry::Initializer::Mixin

    param :client
    param :method
    param :url
    param :params, default: proc { nil }

    API_URL = 'https://secure.payu.com/'.freeze
    API_SANDBOX_URL = 'https://secure.snd.payu.com/'.freeze

    # rubocop:disable Metrics/AbcSize
    def send
      connection = Faraday::Connection.new(api_url)
      connection.public_send(method.to_s.downcase) do |request|
        request.url url
        request.headers['Content-Type'] = 'application/json'
        request.headers['Authorization'] = "Bearer #{client.auth_token}"
        request.body = JSON.generate(params) if params
      end
    rescue Faraday::Error => e
      raise RequestError, e.message
    end

    private

    def api_url
      client.sandbox ? API_SANDBOX_URL : API_URL
    end
  end
end
