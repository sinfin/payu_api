module PayuAPI
  class AuthRequest < Request
    extend Dry::Initializer::Mixin

    option :pos_id
    option :key
    option :sandbox, default: proc { false }

    private

    def sandbox?
      sandbox
    end

    def method
      :POST
    end

    def url
      '/pl/standard/user/oauth/authorize'
    end

    def headers
      { 'Content-Type' => 'application/x-www-form-urlencoded' }
    end

    def body
      "grant_type=client_credentials&client_id=#{pos_id}&client_secret=#{key}"
    end
  end
end
