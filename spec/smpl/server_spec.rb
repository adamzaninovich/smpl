require 'spec_helper'
require 'smpl/server'

describe SMPL::Server do
  before(:each) do
    @port = 3333
    @logger = SMPL::Logger.new(:stdout)
  end
  
  it "exists" do
    SMPL::Server
  end
  
  it "starts the server" do
    EM.run_block {
      @logger.should_receive(:log).with(anything, anything).at_least(:once)
      @logger.should_receive(:log).with("Listening on 0.0.0.0:#{@port}...", :type => :text).once
      SMPL::Server.run(port:@port, logger:@logger)
    }
  end
end
