class Game
  attr_accessor :dict_arr, :word_pool, :secret_word, :guesses,
    :hidden_letters

  private

  def initialize
    @guesses = 10
    @dict_arr = File.read('dictionary.txt').split
  end

  def get_word_pool(dictionary)
    dictionary.select do |word|
      word.length > 4 and word.length < 13
    end
  end

  def word_pool
    @word_pool = get_word_pool(@dict_arr)
  end

  def create_secret_word
    word_pool
    @secret_word = @word_pool.sample
  end

  def hide_letters(secret_word)
    secret_word.each_char.map do |letter|
      '_ '
    end
  end

  def hidden_letters
    @hidden_letters = hide_letters(@secret_word)
  end

  public
  def play
    create_secret_word
    hidden_letters

    until @hidden_letters.join == @secret_word or @guess == 0
      puts "What is your guess? (#{@guesses} remaining)"
      guess = gets

      letter_indices = []
      @secret_word.each_char.each_with_index do |letter, index|
        if guess[0] == letter
          letter_indices << index
        end
      end

      if letter_indices.empty?
        @guesses -= 1
      end

      letter_indices.each do |index|
        @hidden_letters[index] = guess[0]
      end

      puts @hidden_letters.join
    end
  end

end


s = Game.new

s.play