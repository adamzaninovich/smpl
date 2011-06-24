require 'yaml'

module SMPL
  ROOT    = File.expand_path('../../',__FILE__)
  PUBLIC  = SMPL::ROOT + "/public"
  CONFIG  = YAML.load(File.read(SMPL::ROOT + "/config/config.yml"))
end
