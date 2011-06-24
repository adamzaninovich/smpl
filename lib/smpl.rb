require 'yaml'
require 'faye'

module SMPL
  ROOT = File.expand_path('../../',__FILE__)
  CONFIG = YAML.load(File.read(SMPL::ROOT + "/config/config.yml"))
end
