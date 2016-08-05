module PayuAPI
  class Order
    class << self
      def get(client:, order_id:)
        request = Request.new(client: client, method: 'GET', url: "/api/v2_1/orders/#{order_id}")
        GetResponse.new(http_response: request.send)
      end

      def create(client:, params:)
        post_params = params.merge(
          merchantPosId: client.pos_id
        )
        request = Request.new(client, :POST, '/api/v2_1/orders', post_params)
        CreateResponse.new(http_response: request.send)
      end

      def capture(client:, order_id:)
        params = {
          orderId: order_id,
          orderStatus: 'COMPLETED'
        }
        request = Request.new(client, :PUT, "/api/v2_1/orders/#{order_id}/status", params)
        Response.new(http_response: request.send)
      end

      def cancel(client:, order_id:)
        request = Request.new(client, :DELETE, "/api/v2_1/orders/#{order_id}")
        Response.new(http_response: request.send)
      end

      def refund(client:, order_id:, params:)
        post_params = {
          orderId: order_id,
          refund: params
        }
        request = Request.new(client, :POST, "/api/v2_1/orders/#{order_id}/refunds", post_params)
        RefundResponse.new(http_response: request.send)
      end
    end
  end
end
