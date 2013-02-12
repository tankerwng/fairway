module Fairway
  class ChanneledConnection
    def initialize(connection, &block)
      @connection = connection
      @block = block
    end

    def deliver(message)
      channel = @block.call(message)
      @connection.deliver(message, channel)
    end

    def method_missing(method, *args)
      @connection.respond_to?(method) ? @connection.send(method, *args) : super
    end
  end
end
