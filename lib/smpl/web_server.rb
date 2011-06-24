require 'sinatra/base'
require 'sinatra/synchrony'
require 'faye'
require 'rack/coffee'

module SMPL
  class WebServer < Sinatra::Base
    register Sinatra::Synchrony
    
    # Rack Adapters
    
    use Faye::RackAdapter,  mount:      SMPL::CONFIG[:faye][:mount],
                            timeout:    SMPL::CONFIG[:faye][:timeout],
                            extensions: []
    
    use Rack::Coffee, root:   "#{SMPL::ROOT}/public",
                      urls:   SMPL::CONFIG[:coffee][:dir],
                      static: SMPL::CONFIG[:coffee][:static],
                      nowrap: SMPL::CONFIG[:coffee][:nowrap]
    
    # Handlers
    
    get '/' do
      '<pre>' << SMPL::CONFIG.inspect << '</pre>'
    end
    
  end
end
