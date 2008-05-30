begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

require File.dirname(__FILE__) + "/../lib/multibyte"

module UnicodeHelper
  
  def string_format_examples
    {
      :utf8 => "Abcd Блå ﬃ блa  埋",
      :ascii => "asci ias c iia s",
      :bytes => "\270\236\010\210\245"
    }
  end
  
end

Spec::Runner.configure do |config|
  include UnicodeHelper
end