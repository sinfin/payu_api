module PayuAPI
  class ApiRequest < Request
    extend Dry::Initializer::Mixin

    param :client
    param :method
    param :url
    param :params, default: proc { nil }

    private

    def logger
      client.logger
    end

    def sandbox?
      client.sandbox
    end

    def headers
      {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{client.auth_token}"
      }
    end

    def body
      JSON.generate(params) if params
    end
  end
end
