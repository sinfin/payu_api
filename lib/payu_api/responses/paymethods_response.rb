# This methods allows to retrieve paymethods which are enabled for pos.
# For merchants with token payments enabled it also retrieves user payments tokens.
# Token payments requires OAuth token with grant type trusted_merchant.
module PayuAPI
  class PaymethodsResponse < Response
    def card_tokens
      body[:cardTokens] || []
    end

    def pex_tokens
      body[:pexTokens] || []
    end

    def pay_by_links
      body[:payByLinks] || []
    end
  end
end
