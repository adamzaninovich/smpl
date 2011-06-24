require 'faye'

module SMPL
  class Logger
    attr_reader :client, :file, :type

    def initialize(type=nil, filename=nil)
      @file = $stdout
      case type.to_s
      when /bayeux|faye/
        @type = :bayeux
        @client = Faye::Client.new(
          'http://' <<
          SMPL::CONFIG[:web][:host] << ':' << SMPL::CONFIG[:web][:port].to_s << 
          SMPL::CONFIG[:faye][:mount]
        )
      when /file/
        @type = :file
        if filename && filename!=''
          @file = File.new(SMPL::ROOT + '/log/' + filename + '.log', 'a')
          @file.puts("\n>> #{Time.now.ctime} >>>>>>>>>>>>>>>>>>>>>>>>>>>")
          @file.flush
        end
      else
        # stdout
        @type = :file
      end
    end
        
    def log(text, data={:type=>:text})
      if @type == :bayeux
        bayeux_log(text, data)
      else
        if data[:type].nil? or data[:type] == :text
          output = text
        else
          output = "#{data[:ip]}\t#{data[:time].ctime}\t#{text}"
        end
        @file.puts(output)
        @file.flush
      end
    end
    
    private
    def bayeux_log(text,data)
      unless data[:type].nil? or data[:type] == :text
        data.merge!({logger:self.object_id, text:text})
        data[:time] = (data[:time].to_f*1000).to_i
        @client.publish(SMPL::CONFIG[:faye][:channel], data)
      else
        # TODO what happens here?
      end
    end
    
  end
end