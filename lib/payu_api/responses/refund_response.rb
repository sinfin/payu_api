module PayuAPI
  class RefundResponse < Response
    def refund
      body[:refund]
    end
  end
end
