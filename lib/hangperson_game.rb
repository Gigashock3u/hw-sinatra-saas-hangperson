class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word, guesses = '', wrong_guesses='')
    @word = word
    @guesses = guesses
    @wrong_guesses = wrong_guesses
  end
  
  def guess(letter)
    if letter == ''
      raise ArgumentError.new('Its empty')
    elsif letter =~ /[^a-zA-Z]/
      raise ArgumentError.new('Not valid character')
    elsif letter == nil
      raise ArgumentError.new('Its nil')
    end
    letter.downcase!
    if @guesses.match(letter) || @wrong_guesses.match(letter)
      return false
    else
      if @word.match(letter) && !@guesses.match(letter) 
        @guesses+=letter
      elsif !@wrong_guesses.match(letter)
        @wrong_guesses+=letter
      end
      return true
    end
  end

  def word_with_guesses
    
    if @guesses.empty?
      @word_with_guesses = @word.gsub(/\w/,'-')
    else
      @word_with_guesses = @word.gsub(/[^#{@guesses}]/,'-')
    end
  end
  
  def check_win_or_lose
    self.word_with_guesses
    if @wrong_guesses.length == 7 
      :lose
    elsif @word_with_guesses == @word && @wrong_guesses.length < 7
      :win
    else 
      :play
    end
    
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  

end
