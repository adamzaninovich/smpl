require File.expand_path('../lib/smpl/web_server', __FILE__)

# TODO: add in faye as a rack adapter

# TODO serve coffee

# run the web server
run SMPL::WebServer.new
