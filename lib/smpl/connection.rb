require_relative '../smpl'
require_relative 'logger'
require 'eventmachine'

module SMPL
  class Connection < EM::Connection
    
    attr_reader :cid, :data
    
    def self.all
      @@connection
    end
    
    def initialize(logger)
      @@connection ||= {}
      @logger = logger
      @peer = {}
      @cid = nil
      @data = []
    end

    def post_init
      @peer[:port], @peer[:ip] = Socket.unpack_sockaddr_in(get_peername)
      @cid = Socket.unpack_sockaddr_in(get_peername).join.hash
      @@connection[@cid] = self
      @logger.log "Connected", type:'connect', time:Time.new, ip:@peer[:ip]
    end

    def unbind
      @logger.log "Disconnected", type:'disconnect', time:Time.new, ip:@peer[:ip]
      @@connection[@cid] = nil
      @cid = nil
      @peer = nil
    end

    def receive_data(raw_data)
      @buf = BufferedTokenizer.new("\r")
      @buf.extract(raw_data).each do |line|
        # store data
        @data << { time:Time.new, ip:@peer[:ip], line:line, size:line.bytesize }
        
        # publish to stats
        @logger.log "--Data--", type:'data', time:Time.new, ip:@peer[:ip], line:line, size:line.bytesize
        
        # publish to graphs
        
        
      end
    end
    
  end
end