module PayuAPI
  class Error < StandardError
  end

  class RequestError < Error
  end

  class InvalidResponseError < Error
  end
end
