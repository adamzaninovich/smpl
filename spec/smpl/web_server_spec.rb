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
  
  describe "Paths" do
    
    describe "'/'" do
      it "responds" do
        get '/'
        last_response.should be_ok
      end
      it "sends #{SMPL::PUBLIC}/index.html" do
        # public/index.html must exist for this to be accurate
        get '/'
        last_response.body.should == File.read(SMPL::PUBLIC + '/index.html')
      end
    end

    describe "'/images/:image'" do
      describe "when image exists" do
        it "responds" do
          # public/images/github.png must exist for this to be accurate
          get '/images/github.png'
          last_response.should be_ok
        end
      end
      describe "when image doesn't exist" do
        it "sends a 404" do
          get '/images/nonexistent_image.png'
          last_response.status.should == 404
        end
      end
      describe "when other type is requested" do
        it "sends a 404" do
          get '/images/wrong.txt'
          last_response.status.should == 404
        end
      end
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
