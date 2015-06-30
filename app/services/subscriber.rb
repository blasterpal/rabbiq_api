class Subscriber
  # In order to publish message we need a exchange name.
  # Note that RabbitMQ does not care about the payload -
  # we will be using JSON-encoded strings
  def self.subscribe(type, message = {},&blok)
    # grab the fanout exchange
    x = channel.queue("msg.#{type}", auto_delete: true)
    # and simply publish message
    x.subscribe(&blok)# do |delivery_info, properties, payload| 
       
    #end
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

