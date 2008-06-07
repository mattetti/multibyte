require 'rubygems'
require 'open-uri'
require 'utf8proc_native'
require File.dirname(__FILE__) + '/../lib/multibyte/handlers/utf8_handler_proc'

$KCODE = 'UTF8'


UNIDATA_URL = "http://www.unicode.org/Public/#{Multibyte::UNICODE_VERSION}/ucd"
UNIDATA_FILE = '/NormalizationTest.txt'
CACHE_DIR = File.dirname(__FILE__) + '/cache'

class Downloader
  def self.download(from, to)
    unless File.exist?(to)
      $stderr.puts "Downloading #{from} to #{to}"
      unless File.exist?(File.dirname(to))
        system "mkdir -p #{File.dirname(to)}"
      end
      open(from) do |source|
        File.open(to, 'w') do |target|
          source.each_line do |l|
            target.write l
          end
        end
       end
     end
  end
end

class String
  # Unicode Inspect returns the codepoints of the string in hex
  def ui
    "#{self} " + ("[%s]" % unpack("U*").map{|cp| cp.to_s(16) }.join(' '))
  end unless ''.respond_to?(:ui)
end

Dir.mkdir(CACHE_DIR) unless File.exist?(CACHE_DIR)
Downloader.download(UNIDATA_URL + UNIDATA_FILE, CACHE_DIR + UNIDATA_FILE)

def each_line_of_norm_tests(&block)
  lines = 0
  max_test_lines = 0 # Don't limit below 38, because that's the header of the testfile
  File.open(File.dirname(__FILE__) + '/cache' + UNIDATA_FILE, 'r') do | f |
    until f.eof? || (max_test_lines > 38 and lines > max_test_lines)
      lines += 1
      line = f.gets.chomp!
      next if (line.empty? || line =~ /^\#/)      
      
      cols, comment = line.split("#")
      cols = cols.split(";").map{|e| e.strip}.reject{|e| e.empty? }
      next unless cols.length == 5
      
      # codepoints are in hex in the test suite, pack wants them as integers
      cols.map!{|c| c.split.map{|codepoint| codepoint.to_i(16)}.pack("U*") }
      cols << comment
      
      yield(*cols)
    end
  end
end

# begin
#   require 'utf8proc_native'
#   require File.dirname(__FILE__) + '/../lib/multibyte/handlers/utf8_handler_proc'
# rescue LoadError
#   p "make sure you have the utf8proc gem installed"
# end