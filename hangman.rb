class Hangman

    attr_accessor :word_to_guess, :word_shown, :guessed_letter

    def initialize(dictionary_file)
        @word_to_guess = get_word_from_dictionary(dictionary_file)
        @word_shown = []
        @guessed_letter = ""
    end

    def get_word_from_dictionary(dictionary_file)
        word_to_guess = dictionary_file[rand(0..dictionary_file.length - 1)]
        while word_to_guess.length > 12 || word_to_guess.length < 5
            word_to_guess = dictionary_file[rand(0..dictionary_file.length - 1)]
        end
        word_to_guess.chomp
    end
    
    
    def display(word_shown)
        puts word_shown.join("")
    end
    
    
    def player_guess
        print "Guess a letter: "
        player_guess = gets.downcase.chomp
        
        while player_guess.match?(/[A-Z]/i) == false || player_guess.length != 1
            print "Guess a letter: "
            player_guess = gets.downcase.chomp
        end
    
        player_guess.gsub(/\s+/,"")
    end
    
    
    def check_for_letter(word, letter)
        locations = []
        word.downcase.chars.each_with_index {|char, index|
           char == letter ? locations << index : ""
        }
        locations
    end
    
    
    def update_word_shown(word_shown, location_of_guessed_letters, guessed_letter)
        location_of_guessed_letters.each { |index|
                word_shown[index] = guessed_letter
            }
        @word_shown = word_shown
    end
    

end

class Player

end


dictionary_file = File.open('5desk.txt').to_a
save_state = File.open('savestate.txt', 'w')

guesses_left = 6



currentGame = Hangman.new(dictionary_file)
puts currentGame.word_to_guess
currentGame.word_to_guess.length.times { currentGame.word_shown << " _ "}
currentGame.display(currentGame.word_shown)

# # gameplay loop below
guessed_letter = currentGame.player_guess()
location_of_guessed_letters = currentGame.check_for_letter(currentGame.word_to_guess, guessed_letter)
currentGame.update_word_shown(currentGame.word_shown, location_of_guessed_letters, guessed_letter)
currentGame.display(currentGame.word_shown)