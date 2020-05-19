**Hangman**
========

The purpose behind this program was to practice Object Oriented Programming, as well as learn more about serialization and reading/writing to files. 

========

When opening the program, the first thing the script does is check for a file called "savestate.yml." If this does not exist, it means the player either guessed correctly, or lost the last round of the game, in which case there no place for the player to pick back up.

If there is no "savestate.yml" file, or if the player does not want to continue their previous game, a new instance of the Hangman class is created.

Inside the Hangman Class there are 4 Class variables:
    - word_to_guess: When initialized the function get_word_from_dictionary(dictionary_file) is called which opens a .txt file and returns a random word between 5 and 12 letters long which is then saved in this variable.
    - word_shown: An array that contains the player's previously correct guesses(what is shown to the player)
    - incorrect_guesses: An array that contains all previous incorrect guesses by the player.
    - guesses_left: How many incorrect guesses the player has left until they lose.

Then the gameloop begins, which is as follows:
    - First, function player_guess() is called which gets a single letter from the player.
    - Second, the function check_for_letter() is called which takes two inputs, the word to guess and the guessed letter. If there the letter is not present, 1 is subtracted from @guesses_left. Next, check_for_win is called from within check_for_lettter(), which compares the word_shown and word_to_guess. Finally, the function returns the index of each instance of the letter in "word_to_guess"
    - Third, update_word_shown() is called which adds the guessed letter to the index values returned by check_for_letter().
    - Fourth, display() is called which prints word_shown, incorrect_guesses, and prompts the user for their next guess.
    - Fifth, a savestate.yml file is created and the class variables are recorded inside.

========

To use this program, 
1. Make sure you have Ruby installed on your system
2. Install the commandline_chess.rb file
3. Naviagte to the file's location in the terminal
4. Type "ruby hangman.rb" and enter.
5. Play, close, pick up again, enjoy!
