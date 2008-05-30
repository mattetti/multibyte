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
  
  
end