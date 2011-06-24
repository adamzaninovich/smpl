require 'spec_helper'
require 'smpl/logger'

# patch SMPL::Logger with using? method for tests
module SMPL
  class Logger
    def using? type
      case type.to_s
      when /stdout/
        @type == :file and @file == $stdout and @client.nil?
      when /faye|bayeux/
        @type == :bayeux and @file == $stdout and not @client.nil?
      when /file/
        @type == :file and @file != $stdout
      else
        false
      end
    end
  end
end

describe SMPL::Logger do
  it "exists" do
    SMPL::Logger
  end
  
  describe "initialization" do
    it "uses stdout by default" do
      SMPL::Logger.new().should be_using        :stdout
      SMPL::Logger.new('').should be_using      :stdout
      SMPL::Logger.new('blah').should be_using  :stdout
    end
    
    it "uses bayeux when given bayeux option" do
      SMPL::Logger.new(:bayeux).should be_using   :bayeux
      SMPL::Logger.new("bayeux").should be_using  :bayeux
      SMPL::Logger.new(:faye).should be_using     :bayeux
      SMPL::Logger.new("faye").should be_using    :bayeux
    end
    
    it "uses stdout when given file option without filename" do
      SMPL::Logger.new(:file).should be_using   :stdout
      SMPL::Logger.new("file").should be_using  :stdout
    end
    
    it "uses a file when given file option and a filename" do
      SMPL::Logger.new(:file, 'test').should be_using :file
      SMPL::Logger.new("file",'test').should be_using :file
    end
    
    describe "when log file is specified" do
      before(:each) do
        @file_path = SMPL::ROOT + '/log/test.log'
        delete_if_exists @file_path
      end
      after(:each) do
        delete_if_exists @file_path
      end
      
      it "creates a log file" do
        File.exists?(@file_path).should_not be_true
        SMPL::Logger.new(:file, 'test')
        File.exists?(@file_path).should be_true
      end
      
      it "does not log to stdout" do
        SMPL::Logger.new(:file, 'test').file.should_not == $stdout
      end
      
      it "logs to the specified path" do
        SMPL::Logger.new(:file, 'test').file.path.should == @file_path
      end
      
    end
    
  end
end
