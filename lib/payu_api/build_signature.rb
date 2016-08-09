module PayuAPI
  class BuildSignature
    extend Dry::Initializer::Mixin

    option :body
    option :second_key

    def call
      signature = Digest::MD5.hexdigest("#{body}#{second_key}")
      "sender=checkout;signature=#{signature};algorithm=MD5;content=DOCUMENT"
    end
  end
end
