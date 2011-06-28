require 'yaml'

module SMPL
  ROOT    = File.expand_path('../../',__FILE__)
  PUBLIC  = SMPL::ROOT + "/public"
  CONFIG  = YAML.load(File.read(SMPL::ROOT + "/config/config.yml"))
  CONFIG[:web] ||= {}
  CONFIG[:web][:host]   ||= '0.0.0.0'
  CONFIG[:web][:port]   ||= 3000
  CONFIG[:smpl][:host]  ||= '0.0.0.0'
  CONFIG[:smpl][:port]  ||= 3333
end