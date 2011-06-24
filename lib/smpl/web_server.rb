require 'sinatra/base'
require 'sinatra/synchrony'
require 'rack/coffee'
require 'faye'

module SMPL
  class WebServer < Sinatra::Base
    register Sinatra::Synchrony
    
    # Rack Adapters
    
    use Faye::RackAdapter,  mount:      SMPL::CONFIG[:faye][:mount],
                            timeout:    SMPL::CONFIG[:faye][:timeout],
                            extensions: []
    
    use Rack::Coffee, root:   SMPL::PUBLIC,
                      urls:   SMPL::CONFIG[:coffee][:dir],
                      static: SMPL::CONFIG[:coffee][:static],
                      nowrap: SMPL::CONFIG[:coffee][:nowrap]
    
    # Handlers
    
    get '/' do
      send_file SMPL::PUBLIC + '/index.html'
    end
    
    get '/images/:image' do
      if params[:image] =~ /\.(png|jpg|jpeg)\z/i
        halt 404 unless send_file SMPL::PUBLIC + '/images/' + params[:image]
      else
        halt 404
      end
    end
    
  end
end
