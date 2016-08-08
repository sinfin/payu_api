module PayuAPI
  class AuthResponse < Response
    def auth_token
      body[:access_token]
    end

    def expires_in
      body[:expires_in]
    end
  end
end
