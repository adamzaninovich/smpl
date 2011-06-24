require 'smpl'

def delete_if_exists(path)
  File.delete(path) if File.exists?(path)
end