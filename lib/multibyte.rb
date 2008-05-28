$:.unshift File.dirname(__FILE__)
$KCODE = 'u'

module Multibyte #:nodoc:
  DEFAULT_NORMALIZATION_FORM = :kc
  NORMALIZATIONS_FORMS = [:c, :kc, :d, :kd]
  UNICODE_VERSION = '5.0.0'
end

require 'multibyte/chars'
require 'unicode'

class String #:nodoc:
  include CoreExtensions::String::Unicode
end