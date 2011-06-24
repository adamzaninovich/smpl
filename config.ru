LIBS = File.expand_path('../lib', __FILE__)

require "#{LIBS}/smpl"
require "#{LIBS}/smpl/web_server"

# run the web server
run SMPL::WebServer.new
