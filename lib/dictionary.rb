require 'singleton'

class Dictionary
  include Singleton

  class << self #opens up self's singleton class, so that methods can be redefined 
                #for the current self object (which inside a class or module body
                #is the class or module itself)
                #class is Dictionary which opens up self
                
    attr_accessor :words #attribute accessor. words is the attribute (instance variable)
  end

  # We load the dictionary file into the @words class variable.
  # We only want to load the dictionary file if the @words class variable is empty.
  def self.load_dictionary
    if !@words.kind_of?(Array) #check to see if @words is NOT an array
      @words = [] #if it is not an array, make it an empty array
      File.open("/usr/share/dict/words", "r").each_line do |line|
        @words.push(line)
      end
    end
  end

end
