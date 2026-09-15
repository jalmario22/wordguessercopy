class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = String.new
    @wrong_guesses = String.new
    @displayed = '_' * word.length
  end

  def alpha?(letter)
    "qwertyuiopasdfghjklzxcvbnm".include?(letter.downcase)
  end

  def guess(letter)
    if letter == '' or letter == nil or not alpha?(letter)
      raise ArgumentError, "Invalid guess."
      return
    end
    letter = letter.downcase
    if @word.include?(letter)
      if not @guesses.include?(letter)
        @guesses+=letter
      else
        raise ArgumentError, "You have already used that letter."
        return false
      end
    else 
      if not @wrong_guesses.include?(letter)
        @wrong_guesses+=letter
      else
        raise ArgumentError, "You have already used that letter."
        return false
      end
    end
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7
      :lose
    elsif self.word_with_guesses == @word
      :win
    else
      :play
    end
  end

  def word_with_guesses
    displayed = ""
    @word.chars do |letter|
      if @guesses.include?(letter)
        displayed += letter
      else
        displayed += '-'
      end
    end
    return displayed
  end
  # Get a word from remote "random word" service

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord.txt')
    Net::HTTP.get(uri)
  end
end
