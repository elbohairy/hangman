dict_str = File.read('dictionary.txt')

dict_arr = dict_str.split()

secret_words = dict_arr.select do |word|
  word.length > 4 and word.length < 13
end

secret_word = secret_words.sample

guesses = 10

def make_hidden_letters_array(secret_word)
  secret_word.each_char.map do |letter|
    '_ '
  end    
end

puts "here's ur word"

hidden_letters = make_hidden_letters_array(secret_word)

p secret_word

puts hidden_letters.join

puts "wuz ur guess"
guess = gets


letter_indices = []
secret_word.each_char.each_with_index do |letter, index|
  if guess[0] == letter
    letter_indices << index
  end
end

letter_indices.each do |index|
  hidden_letters[index] = guess[0]
end

puts hidden_letters.join