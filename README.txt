Multibyte
==========

Multibyte is extracted directly from Rails's ActiveSupport and offers Multibyte safety to Ruby. 

Usage
=====

>> require 'multibyte'
=> true
>> "新通訊錄".chars[0..1]
=> #<Multibyte::Chars:0x127e3d0 @string="新通">
>> "新通訊錄".chars[0..1].to_s
=> "新通"
