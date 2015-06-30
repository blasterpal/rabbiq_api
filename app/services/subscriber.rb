class Subscriber
  # In order to publish message we need a exchange name.
  # Note that RabbitMQ does not care about the payload -
  # we will be using JSON-encoded strings
  def self.pop(type, message = {},&blok)
    q = channel.queue("msg.#{type}", auto_delete: true)
    the_payload = nil
    q.subscribe(block: true) do |delivery_info, _, payload|
      the_payload = payload
      channel.consumers[delivery_info.consumer_tag].cancel
    end     
    the_payload
  end

  def self.channel
    @channel ||= connection.create_channel
  end

  # We are using default settings here
  # The `Bunny.new(...)` is a place to
  # put any specific RabbitMQ settings
  # like host or port
  def self.connection
    @connection ||= Bunny.new.tap do |c|
      c.start
    end
  end
end

