require File.dirname(__FILE__) + '/spec_helper.rb'
require File.dirname(__FILE__) + '/conformance_helper.rb'

if RUBY_VERSION < '1.9'
  describe 'conformance' do
    
    before(:each) do
      @handler = Multibyte::Handlers::UTF8HandlerProc
    end
  
    describe "should be able to use normalization Form C" do
      each_line_of_norm_tests do |*cols|
        col1, col2, col3, col4, col5, comment = *cols

        # CONFORMANCE:
        # 1. The following invariants must be true for all conformant implementations
        #    NFC
        #      c2 ==  NFC(c1) ==  NFC(c2) ==  NFC(c3)
        
        it "Form C - Col 2 has to be NFC(1) - #{comment}" do          
          @handler.normalize(col1, :c).ui.should == col2.ui
        end
        
        it "Form C - Col 2 has to be NFC(2) - #{comment}" do
          @handler.normalize(col2, :c).ui.should == col2.ui
        end
        
        it "Form C - Col 2 has to be NFC(3) - #{comment}" do
          @handler.normalize(col3, :c).ui.should == col2.ui
        end
        
        #
        #      c4 ==  NFC(c4) ==  NFC(c5)
        it "Form C - Col 4 has to be C(4) - #{comment}" do
          @handler.normalize(col4, :c).ui.should == col4.ui
        end
        
        it "Form C - Col 4 has to be C(5) - #{comment}" do
          @handler.normalize(col5, :c).ui.should == col4.ui
        end
      end
    end
  
    describe "should be able to use normalization Form D" do
      each_line_of_norm_tests do |*cols|
        col1, col2, col3, col4, col5, comment = *cols
        #
        #    NFD
        #      c3 ==  NFD(c1) ==  NFD(c2) ==  NFD(c3)
        it "Form D - Col 3 has to be NFD(1) - #{comment}" do
          @handler.normalize(col1, :d).ui.should == col3.ui
        end
        
        it "Form D - Col 3 has to be NFD(2) - #{comment}" do
          @handler.normalize(col2, :d).ui.should == col3.ui
        end
        
        it "Form D - Col 3 has to be NFD(3) - #{comment}" do
          @handler.normalize(col3, :d).ui.should == col3.ui
        end
        
        #      c5 ==  NFD(c4) ==  NFD(c5)
        it "Form D - Col 5 has to be NFD(4) - #{comment}" do
          @handler.normalize(col4, :d).ui.should == col5.ui
        end
        
        it "Form D - Col 5 has to be NFD(5) - #{comment}" do
          @handler.normalize(col5, :d).ui.should == col5.ui
        end
        
      end
    end
    
    describe 'should be able to use normalization Form KC' do
      each_line_of_norm_tests do | *cols |
        col1, col2, col3, col4, col5, comment = *cols  
        #
        #    NFKC
        #      c4 == NFKC(c1) == NFKC(c2) == NFKC(c3) == NFKC(c4) == NFKC(c5)
        it "Form D - Col 4 has to be NFKC(1) - #{comment}" do
          @handler.normalize(col1, :kc).ui.should == col4.ui
        end
        
        it "Form D - Col 4 has to be NFKC(2) - #{comment}" do
          @handler.normalize(col2, :kc).ui.should == col4.ui
        end
        
        it "Form D - Col 4 has to be NFKC(3) - #{comment}" do
          @handler.normalize(col3, :kc).ui.should == col4.ui
        end
        
        it "Form D - Col 4 has to be NFKC(4) - #{comment}" do
          @handler.normalize(col4, :kc).ui.should == col4.ui
        end
        
        it "Form D - Col 4 has to be NFKC(5) - #{comment}" do
          @handler.normalize(col5, :kc).ui.should == col4.ui
        end
        
      end
    end
  
    describe 'should be able to use nomalization Form KD' do
      each_line_of_norm_tests do | *cols |
        col1, col2, col3, col4, col5, comment = *cols  
        #
        #    NFKD
        #      c5 == NFKD(c1) == NFKD(c2) == NFKD(c3) == NFKD(c4) == NFKD(c5)
        it "Form KD - Col 5 has to be NFKD(1) - #{comment}" do
           @handler.normalize(col1, :kd).ui.should == col5.ui
        end
        
        it "Form KD - Col 5 has to be NFKD(2) - #{comment}" do
           @handler.normalize(col2, :kd).ui.should == col5.ui
        end
        
        it "Form KD - Col 5 has to be NFKD(3) - #{comment}" do
           @handler.normalize(col3, :kd).ui.should == col5.ui
        end
        
        it "Form KD - Col 5 has to be NFKD(4) - #{comment}" do
           @handler.normalize(col4, :kd).ui.should == col5.ui
        end
        
        it "Form KD - Col 5 has to be NFKD(5) - #{comment}" do
           @handler.normalize(col5, :kd).ui.should == col5.ui
        end
        
      end
    end
    
  end
end