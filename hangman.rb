require 'yaml'

class Hangman

    attr_accessor :word_to_guess, :word_shown, :guessed_letter, :previously_guessed

    def initialize(dictionary_file)
        @word_to_guess = get_word_from_dictionary(dictionary_file)
        @word_shown = []
        @incorrect_guesses = []
        @guesses_left = 6
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
        puts "Incorrect guesses: #{@incorrect_guesses.join("")}"
        print "Guess a letter: "
        player_guess = gets.downcase.chomp
        puts " "
        
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
        if locations == []
            @incorrect_guesses << letter
            puts "Incorrect guess! #{@guesses_left} attempts left!"
            @guesses_left -= 1
        end

        self.check_for_win
        locations
    end
    
    def update_word_shown(word_shown, location_of_guessed_letters, guessed_letter)
        location_of_guessed_letters.each { |index|
                word_shown[index] = guessed_letter
            }
        @word_shown = word_shown
    end

    def check_for_win
       if @word_shown.include?(" _ ") == false
        # delete savestate if player wins
        File.delete('savestate.yml')
        true
       else
        false
       end
    end

    def still_have_guesses?
        if @guesses_left > 0
            true
        else
            false
        end
    end

end

class Player


end





dictionary_file = File.open('5desk.txt').to_a

# initialize game
if File.exist?('savestate.yml')
    print "Do you want to reload your last game? Y/N: "
    replay = gets.chomp
end

if replay != nil && replay.downcase == "y"
    currentGame = YAML.load(File.read('savestate.yml'))
    currentGame.display(currentGame.word_shown)
else
    currentGame = Hangman.new(dictionary_file)
    puts currentGame.word_to_guess
    currentGame.word_to_guess.length.times { currentGame.word_shown << " _ "}
    currentGame.display(currentGame.word_shown)
end





# # gameplay loop
while currentGame.check_for_win() == false && currentGame.still_have_guesses? == true
    guessed_letter = currentGame.player_guess()
    location_of_guessed_letters = currentGame.check_for_letter(currentGame.word_to_guess, guessed_letter)
    currentGame.update_word_shown(currentGame.word_shown, location_of_guessed_letters, guessed_letter)
    currentGame.display(currentGame.word_shown)
    File.open('savestate.yml','w'){|file| file.write(currentGame.to_yaml)}
end

# implement save state
# record 
    # @word_to_guess = get_word_from_dictionary(dictionary_file)
    # @word_shown = []
    # @previously_guessed = []
    # @guesses_left = 6

