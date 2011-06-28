require_relative '../smpl'
require 'sinatra/base'
require 'sinatra/synchrony'
require 'rack/coffee'
require 'sass'
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
    
    # Config
    
    disable :run
    set :root, SMPL::ROOT
    set :bind, SMPL::CONFIG[:web][:host]
    set :port, SMPL::CONFIG[:web][:port]
    set :sass, :style => :compact
    set :views, Proc.new { File.join(SMPL::ROOT, 'resources', 'views') }
    
    # Handlers
    
    get '/' do
      redirect '/stats'
    end
    
    get '/stats' do
      erb :stats
    end
    
    get '/graphs' do
      erb :graphs
    end
    
    get '/help' do
      erb :help
    end
    
    get '/css/style.css' do
      sass :main
    end
    
    get '/images/:image' do
      if params[:image] =~ /\.(png|jpg|jpeg)\z/i
        halt 404 unless send_file File.join(SMPL::PUBLIC, 'images', params[:image])
      else
        halt 404
      end
    end
    
  end
end
