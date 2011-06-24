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
  
  describe "Faye" do
    it "mounts faye at #{SMPL::CONFIG[:faye][:mount]}" do
      get "#{SMPL::CONFIG[:faye][:mount]}.js"
      last_response.should be_ok
    end
  end
  
  describe "Coffee" do
    it "renders CoffeeScript files placed in public#{SMPL::CONFIG[:coffee][:dir]}" do
      get "#{SMPL::CONFIG[:coffee][:dir]}/smpl.js"
      last_response.should be_ok
    end
  end

end
