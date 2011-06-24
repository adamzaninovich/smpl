require 'spec_helper'
require 'smpl/web_server'
require 'rack/test'

# Set Sinatra env to test
module SMPL
  class WebServer
    set :environment, :test
  end
end

describe SMPL::WebServer do
  include Rack::Test::Methods
  
  def app
    @app ||= SMPL::WebServer.new
  end
  
  describe "GET /" do
    it "responds" do
      get '/'
      last_response.should be_ok
    end
  end

  alias_method :request,  :last_request
  alias_method :response, :last_response
end
