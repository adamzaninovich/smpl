LIBS = File.expand_path('../lib', __FILE__)

require "#{LIBS}/smpl/server"
require "#{LIBS}/smpl/web_server"

#Schedule the SMPL Server to start
EM.schedule { SMPL::Server.run logger:SMPL::Logger.new(:faye) }

# run the web server
run SMPL::WebServer.new
