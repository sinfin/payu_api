module PayuAPI
  class GetResponse < Response
    def order
      body[:orders] && body[:orders][0]
    end
  end
end
