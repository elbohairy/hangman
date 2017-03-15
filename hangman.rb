# Some possible future changes:
# => Have the game ask you want to play again after finishing a save or
# non-saved game
# => Show the winning word of the user fails to guess it
# => Clean up the methods. Some methods are doing a lot of work.
# => More refactoring in general.

require 'yaml'

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

  def set_hidden_letters
    @hidden_letters = hide_letters(@secret_word)
  end

  def save
    File.open(Time.new.strftime("%Y-%d-%m-%T.yml"), 'w') do |file|
      file.puts YAML::dump(self)
    end
  end

  def list_saves
    counter = 0
    saves = {}
    Dir.entries(Dir.pwd).each do |file|
      if file.match(/\.yml/)
        puts "#{counter} #{file}"
        saves[counter] = file
        counter += 1
      end
    end

    saves
  end

  def load
    puts "Would you like to load a previous save? (Y or N)"
    answer = gets.chomp
    if answer == 'N'
      return
    end
    saves = list_saves
    puts "Enter the corresponding number to load the save"
    number = gets
    save_file = ''
    saves.each do |num, file|
      if number.to_i == num
        save_file = file
      end
    end

    yaml_string = File.read(save_file)
    save = YAML::load(yaml_string)

    @guesses = save.guesses
    @hidden_letters = save.hidden_letters
    @secret_word = save.secret_word

    play_from_save

  end

  def play_from_save
     puts @hidden_letters.join
    until @hidden_letters.join == @secret_word or @guesses == 0
      puts "What is your guess? (#{@guesses} remaining) (Enter 1 to save)"
      guess = gets

      if guess.to_i == 1
        save
        redo
      end

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
    exit
  end


  public
  def play
    load
    create_secret_word
    set_hidden_letters

    puts @hidden_letters.join
    until @hidden_letters.join == @secret_word or @guesses == 0
      puts "What is your guess? (#{@guesses} remaining) (Enter 1 to save)"
      guess = gets

      if guess.to_i == 1
        save
        redo
      end

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