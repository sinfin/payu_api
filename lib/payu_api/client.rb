module PayuAPI
  class Client
    extend Dry::Initializer::Mixin

    option :pos_id
    option :auth_token
    option :sandbox, default: proc { false }
    option :logger, default: proc { nil }

    def create_order(order_params)
      Order.create(client: self, params: order_params)
    end

    def get_order(order_id:)
      Order.get(client: self, order_id: order_id)
    end

    def capture(order_id:)
      Order.capture(client: self, order_id: order_id)
    end

    def cancel(order_id:)
      Order.cancel(client: self, order_id: order_id)
    end

    def refund(order_id:, params:)
      Order.refund(client: self, order_id: order_id, params: params)
    end

    def get_paymethods
      Paymethods.get(client: self)
    end
  end
end
