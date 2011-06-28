require_relative '../smpl'
require_relative 'logger'
require_relative 'connection'
require 'eventmachine'

# Usage:
#   SMPL::Server.run(logger:SMPL::Logger.new(:bayeux))
#   SMPL::Server.run(host:'my.domain.com', port:1234, log:'my_log_file')

module SMPL
  class Server
    
    def self.run(options={})
      opts = {
        # Defaults
        host:   SMPL::CONFIG[:smpl][:host],
        port:   SMPL::CONFIG[:smpl][:port],
        log:    nil,
        logger: nil
      }.merge!(options)
      
      new(
        opts[:host],
        opts[:port],
        opts[:logger] || SMPL::Logger.new(:file,opts[:log])
      ).run
    end
    
    def initialize(host, port, logger)
      @host, @port, @logger = host, port, logger
    end
    
    def run
      # Start the EventMachine reactor
      @logger.log "Starting Server...", type: :text
      
      EM.run {
        
        # Catch ^C and exit gracefully
        trap 'INT' do
          puts "\nCaught SIGINT. Stopping..."
          EM.stop
        end
        
        # Starts server with SMPL::Connection passing in @logger to each new instance
        EM.start_server @host, @port, SMPL::Connection, @logger
        @logger.log "Listening on #{@host}:#{@port}...", :type => :text
      }
    end
  end
end