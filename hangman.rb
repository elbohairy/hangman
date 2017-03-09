dict_arr = File.read('dictionary.txt').split

def get_word_pool(dictionary)
  dictionary.select do |word|
    word.length > 4 and word.length < 13
  end
end

word_pool = get_word_pool(dict_arr)

$secret_word = word_pool.sample


$guesses = 10

def hide_letters(secret_word)
  secret_word.each_char.map do |letter|
    '_ '
  end    
end

puts "here's ur word"

$hidden_letters = hide_letters($secret_word)

p $secret_word

#puts hidden_letters.join

#puts "wuz ur guess"
#guess = gets


#letter_indices = []
#secret_word.each_char.each_with_index do |letter, index|
#  if guess[0] == letter
#    letter_indices << index
#  end
#end

#letter_indices.each do |index|
#  hidden_letters[index] = guess[0]
#end

#puts hidden_letters.join


def play
  until $hidden_letters.join == $secret_word or $guesses == 0
    puts "wuz ur guess (#{$guesses} remaining)"
    guess = gets
    


    letter_indices = []
    $secret_word.each_char.each_with_index do |letter, index|
      if guess[0] == letter
        letter_indices << index
      end
    end

    if letter_indices.empty?
      $guesses -= 1
    end

    letter_indices.each do |index|
      $hidden_letters[index] = guess[0]
    end

    puts $hidden_letters.join
  end
end

play