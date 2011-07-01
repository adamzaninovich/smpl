require 'spec_helper'
require 'smpl/connection'

describe SMPL::Connection do
  
  before(:each) do
    @logger = SMPL::Logger.new(:stdout)
    @port = 3333
  end
  
  it "exists" do
    SMPL::Connection
  end
  
  describe "post_init" do
    it "logs 'Connected'" do
      EM.run_block {
        @logger.should_receive(:log).with(/Connected/, anything).once
        @logger.should_receive(:log).with(anything, anything).once # account unbind's msg
        EM.start_server '0.0.0.0', @port, SMPL::Connection, @logger
        EM.fork_reactor { EM.connect '127.0.0.1', @port, TestConnection }
      }
    end
  end
  
  describe "unbind" do
    it "logs 'Disconnected" do
      EM.run_block {
        @logger.should_receive(:log).with(anything, anything).once # account post_init's msg
        @logger.should_receive(:log).with(/Disconnected/, anything).once
        EM.start_server '0.0.0.0', @port, SMPL::Connection, @logger
        EM.fork_reactor { EM.connect '127.0.0.1', @port, TestConnection }
      }
    end
  end
  
  describe "receive_data" do
    it "logs '--Data--'" do
      EM.run {
        @logger.should_receive(:log).with(anything, anything).at_least(:once)
        @logger.should_receive(:log).with(/--Data--/, anything).once
        EM.start_server '0.0.0.0', @port, SMPL::Connection, @logger
        EM.fork_reactor { EM.connect '127.0.0.1', @port, TestData }
        
        # When this spec is run with EM.run_block, the reactor stops before
        # data can be received. Using EM.run and this next line, the spec
        # waits for data to be written before stopping.
        
        EM.add_timer { EM.stop }
      }
    end
  end
  
end

module TestConnection
  def post_init
    close_connection
  end
  def unbind
    EM.stop
  end
end

module TestData
  def post_init
    send_data "Hello\r"
    close_connection_after_writing
  end
  def unbind
    EM.stop
  end
end
