module PayuAPI
  class Order
    class << self
      def get(client:, order_id:)
        request = ApiRequest.new(client, :GET, "/api/v2_1/orders/#{order_id}")
        GetResponse.new(http_response: request.call)
      end

      def create(client:, params:)
        post_params = params.merge(
          merchantPosId: client.pos_id
        )
        request = ApiRequest.new(client, :POST, '/api/v2_1/orders', post_params)
        CreateResponse.new(http_response: request.call)
      end

      def capture(client:, order_id:)
        params = {
          orderId: order_id,
          orderStatus: 'COMPLETED'
        }
        request = ApiRequest.new(client, :PUT, "/api/v2_1/orders/#{order_id}/status", params)
        Response.new(http_response: request.call)
      end

      def cancel(client:, order_id:)
        request = ApiRequest.new(client, :DELETE, "/api/v2_1/orders/#{order_id}")
        Response.new(http_response: request.call)
      end

      def refund(client:, order_id:, params:)
        post_params = {
          orderId: order_id,
          refund: params
        }
        request = ApiRequest.new(client, :POST, "/api/v2_1/orders/#{order_id}/refunds", post_params)
        RefundResponse.new(http_response: request.call)
      end
    end
  end
end
