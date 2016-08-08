require 'json'
require 'faraday'
require 'dry-initializer'

require 'payu_api/version'
require 'payu_api/errors'
require 'payu_api/request'
require 'payu_api/api_request'
require 'payu_api/auth_request'
require 'payu_api/response'
require 'payu_api/responses/auth_response'
require 'payu_api/responses/get_response'
require 'payu_api/responses/create_response'
require 'payu_api/responses/refund_response'
require 'payu_api/order'
require 'payu_api/client'

module PayuAPI
  def self.authorize(pos_id:, key:, sandbox: false)
    request = AuthRequest.new(pos_id: pos_id, key: key, sandbox: sandbox)
    AuthResponse.new(http_response: request.call)
  end
end
