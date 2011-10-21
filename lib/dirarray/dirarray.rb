module Dirarray
  class Dirarray
    attr_accessor :path
    def initialize(path)
      @path = path
    end

    def array
      a = []
      dir = Dir.new(@path)
      files = []
      dir.each {|e|
        next if (e == '..' || e == '.' || e.to_s[0] == '.')
        files << e
      }
      files.sort!
      files.each {|file|
        f = File.new(@path + file)
        next if 'file' != File.ftype(f)
        s = open(f).read.chomp!
        a << {
          :name => File.basename(f),
          :body => (s.nil?)? '' : s.force_encoding('utf-8')
        }
      }
      a
    end
  end
end
