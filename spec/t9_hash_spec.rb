require_relative "spec_helper"

describe T9Hash do
  it "should load the dictionary file into memory on initialize" do
    Dictionary.should_receive(:load_dictionary)
    T9Hash.new("foobar")
  end

  context "after the dictionary is loaded" do #this is dummy data. This sets the environment for the test that follow
    before(:each) do
      @t9_hash  = T9Hash.new("43556")
    end

    it "should translate a hash into an array of letters" do
      @t9_hash.should_receive(:perform_lookup) #this line wants to "perform lookup"
      @t9_hash.to_words #if it runs "to_words" that means "perform lookup" is in "to_words"
    end

    it "should combine an array of letters into word combinations" do
      array_of_arrays = [["g", "h", "i"], ["d", "e", "f"], ["j", "k", "l"], ["j", "k", "l"], ["m", "n", "o"]]

      @t9_hash.should_receive(:combine_letters).with(array_of_arrays)
      @t9_hash.to_words
    end

    it "should convert the hash into the possible word combinations" do
      @t9_hash.stub(:combine_letters).and_return(["hi", "madeupword"]) #hash.stub gives us back a hash
      @t9_hash.should_receive(:filter_against_dictionary).with(["hi", "madeupword"])
      @t9_hash.to_words
    end

    context "filtering against the dictionary" do
      before(:each) do
        Dictionary.stub(:words => ["hi", "hello"])
      end

      it "should return words from the dictionary" do
        @t9_hash.to_words.should eq(["hello"])
      end
    end
  end
end
