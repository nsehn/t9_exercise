require_relative 'dictionary'

class T9Hash

  REVERSE_LOOKUP_TABLE = {
    "2" => ["a", "b", "c"],
    "3" => ["d", "e", "f"],
    "4" => ["g", "h", "i"],
    "5" => ["j", "k", "l"],
    "6" => ["m", "n", "o"],
    "7" => ["p", "q", "r", "s"],
    "8" => ["t", "u", "v", "w"],
    "9" => ["x", "y", "z"]
  }

  def initialize(hash)
    Dictionary.load_dictionary
    @hash = hash
  end

  def to_words
    puts "inside to_words"
    return translate
    # perform_lookup
    # combine_letters(@combo_array)

    # filter_against_dictionary(@final_array)
  end

  private
  def translate
    letter_combinations = perform_lookup
    word_combinations   = combine_letters(letter_combinations)
    filter_against_dictionary(word_combinations)
    puts "inside translate"
  end

  # This converts the T9 numbers into letters
  # i.e. 2 => ["a", "b", "c"]
  def perform_lookup
    numerical_array = @hash.split(//) #This will split the string into an array of strings, which in this case would be each number
    combo_array = []

    numerical_array.each do |fn|
      number_values = REVERSE_LOOKUP_TABLE[fn] #values of the keys
      combo_array.push(number_values) #could also have used h.to_a
    end
    return combo_array
  end

  # This combines a nested array into words
  # i.e. ["g", "h", "i"], ["d", "e", "f"]] => ["ge", "ge", "gf", "hd"..... etc]
  # We want to make sure we have at least one letter for this method to work
  def combine_letters(nested_letters)
    if (nested_letters.kind_of?(Array) & nested_letters.length == 0)
      return
    end
    final_array = []
    final_array = nested_letters[0].product(*nested_letters[1..-1]) # * takes away the outer bracket and just leaves the elements and doesn't make the product an array. It leaves the ARGUMENTS!!!
    final_array.collect! {|x| x.join } 
    return final_array
  end

  # This will find any words that exist in both Dictionary.words and array_of_words
  def filter_against_dictionary(array_of_words)
    return unless (array_of_words & Dictionary.words)
  end
end
