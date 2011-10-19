module Dirarray
  class Dirarray
    attr_accessor :path
    def initialize(path)
      @path = path
    end

    def array
      a = []
      dir = Dir.new(@path)
      dir.each {|e|
        next if (e == '..' || e == '.' || e.to_s[0] == '.')
        f = File.new(@path + e)
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
