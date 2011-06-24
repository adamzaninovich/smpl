require 'sinatra/base'
require 'sinatra/synchrony'

module SMPL
  class WebServer < Sinatra::Base
    register Sinatra::Synchrony
    
    get '/' do
      'Hello'
    end
    
  end
end