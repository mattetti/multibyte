require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.rubyforge.org/
describe "Chars" do
  
  describe 'dealing with different string formats' do
  
    string_format_examples.each do |type, string|
      describe "a #{type} string" do
        it "should have the chars method" do
            string.should respond_to(:chars)
        end
      
        it "should have the to_s method" do
          string.should respond_to(:to_s)
        end
        
        it "should return an instance of Chars" do
          string.chars.should be_an_instance_of(Multibyte::Chars)
        end
        
        it "should not be changed when Chars#to_s is used" do
          string.chars.to_s.should == string
        end
      end
    end
    
  end
    
    
  describe 'comparison' do
    
    it "should be able to compare normal strings properly" do
      'a'.should == 'a'
      'a'.should_not == 'b'
    end
  
    it "should be able to compare chars strings" do
    "a".chars.should_not == "b".chars
    "a".chars.should == "A".downcase.chars
     "a".chars.should == "A".downcase
    end
    
    it "should not support strict comparison" do
      string_format_examples[:utf8].eql?(string_format_examples[:utf8].chars).should be_false
    end
    
    it "should be compared by their enclosed string" do
      string_format_examples[:utf8].should == string_format_examples[:utf8].chars
      other_string = string_format_examples[:utf8].dup
      other_string.should == string_format_examples[:utf8].chars
      other_string.chars.should == string_format_examples[:utf8].chars
    end
    
    it "should be sortable based on their enclosed string" do
      unsorted_strings = ['builder'.chars, 'armor'.chars, 'zebra'.chars]
      unsorted_strings.sort!
      ['armor', 'builder', 'zebra'].should == unsorted_strings
    end
  
  end
  
  describe 'utf8?' do
    
    it "should know that UTF-8 strings are UTF-8" do
      string_format_examples[:utf8].is_utf8?.should be_true
    end
    
    it "should know that ascii strings are also valid UTF-8" do
      string_format_examples[:ascii].is_utf8?.should be_true
    end
    
    it "should know that bytestrings not valid utf-8" do
      string_format_examples[:bytes].is_utf8?.should be_false
    end
    
  end
  
  describe 'gsub' do
    
    it "should be able to gsub" do
      'café'.chars.gsub(/f/, 't').should == 'caté'
      "我的影片".chars.gsub(/片/, 'X').should == "我的影X"
    end
    
    it "should be to gsub even without the kcode setup" do
      with_kcode('none') do
        'éda'.chars.gsub(/d/, 'x').should == 'éxa'
      end
    end
    
  end
  
  describe 'split' do
    
    before(:each) do
      @word = "eﬃcient"
      @chars = ["e", "ﬃ", "c", "i", "e", "n", "t"]
    end

    it "should split by chars" do
      @word.split(//).should == @chars
      @chars.should == @word.chars.split(//)
    end
    
    it "should return Chars instances" do
      @word.chars.split(//).first.should be_an_instance_of(Multibyte::Chars)
    end
    
  end
  
  describe 'regexp matching' do
    
    it "should should use String when kcode not set" do
      with_kcode('none') do
        (string_format_examples[:utf8].chars =~ /ﬃ/).should == 12
      end
    end
    
    it "should be unicode aware" do
      with_kcode('UTF8') do
        (string_format_examples[:utf8].chars =~ /ﬃ/).should == 9
      end
    end
    
    it "should return nil if no matches were found" do
      with_kcode('UTF8') do
        (''.chars =~ /\d+/).should be_nil
      end
    end
    
  end
  
  describe 'UTF8 pragma' do
    
    it "should be on because KCODE is UTF8" do
      if RUBY_VERSION < '1.9'
        with_kcode('UTF8') do
          " ".chars.send(:utf8_pragma?).should be_true
        end
      end
    end
    
    it "should be off because KCODE is UTF8" do
      if RUBY_VERSION < '1.9'
        with_kcode('none') do
          " ".chars.send(:utf8_pragma?).should be_false
        end
      end
    end
    
    it "should be OFF on Ruby 1.9" do
      if RUBY_VERSION > '1.9'
        " ".chars.send(:utf8_pragma?).shoud be_false
      end
    end
    
  end
  
  describe 'handler settings' do
    
    before(:each) do
      @handler = ''.chars.handler
    end
    
    after(:all) do
      Multibyte::Chars.handler = Multibyte::Handlers::UTF8Handler
    end
    
    it "should process use and set handlers in the proper order" do
      Multibyte::Chars.handler = :first
      ''.chars.handler.should == :first
      
      Multibyte::Chars.handler = :second
      ''.chars.handler.should == :second
      
      Multibyte::Chars.handler = @handler
    end
    
    it "should raise an error" do
      lambda{''.chars.handler.split}.should raise_error
    end

  end
  
  describe 'method chaining' do
    
    it "should return a chars instance when using downcase" do
      ''.chars.downcase.should be_an_instance_of(Multibyte::Chars)
    end
    
    it "should return a chars instance when using downcase" do
      ''.chars.strip.should be_an_instance_of(Multibyte::Chars)
    end
    
    it "should forward the chars instance down the down call path of chaining" do
      stripped = ''.chars.downcase.strip
      stripped.should be_an_instance_of(Multibyte::Chars)
    end
    
    it "should output a comparable result than a string result" do
      "  FOO   ".chars.normalize.downcase.strip.should == 'foo'
    end
    
  end
  
  describe 'passthrough_on_kcode' do
    # The easiest way to check if the passthrough is in place is through #size
    with_kcode('none') do
      string_format_examples[:utf8].chars.size.should == 26
    end
    
    with_kcode('UTF8') do
      string_format_examples[:utf8].chars.size.should == 17
    end
  end
  
  describe 'desctructiveness' do
    # Note that we're testing the destructiveness here and not the correct behaviour of the methods
    
    before(:each) do
      @str = 'ac'
    end
    
    it "should be destructive when using Insert on a string" do
      @str.chars.insert(1, 'b')
      @str.should == 'abc'
    end
    
    it "should be destructive when using reverse! on a string" do
      @str.chars.reverse!
      @str.should == 'ca'
    end
    
  end
  
  describe 'resilience' do
    
    it "should contain interpretable bytes" do
      string_format_examples[:bytes].chars.size.should == 5
    end
    
    it "should only yield interpretable bytes when a string is reversed" do
      reversed = [0xb8, 0x17e, 0x8, 0x2c6, 0xa5].reverse.pack('U*')
      string_format_examples[:bytes].chars.reverse.to_s.should == reversed
      string_format_examples[:bytes].chars.reverse!.to_s.should == reversed
    end
  end
  
  describe 'duck typing' do
    
    it "should respond normally to String methods" do
      'test'.chars.respond_to?(:strip).should be_true
      'test'.chars.respond_to?(:normalize).should be_true
      'test'.chars.respond_to?(:normalize!).should be_true
      'test'.chars.respond_to?(:a_method_that_doesnt_exist).should be_false
    end
    
  end 
  
end