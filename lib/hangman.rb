require 'pry-byebug'

def choose_random_word
    begin
        dictionary = File.open("google-10000-english-no-swears.txt", "r")
        word = "A"

        while (word.length < 6 || word.length > 13)
            word_number = rand(9894) + 1
            word = dictionary.readlines[word_number]
            word = "A" if word == nil
            dictionary.rewind
        end
        return word
        dictionary.close
    rescue
        "Could not generate word, try again later :("
        exit
    end
end

class Game
    def initialize
        @secret_word = choose_random_word().upcase.split('')
        @secret_word.slice!(@secret_word.length - 1)
        @mistakes_left = 7
        @incorrect_letters = []
        @player_guesses = Array.new(@secret_word.length, "_")
    end

    def get_player_guess
        print "Enter a letter: "
        @letter_guess = gets.chomp.upcase
    end

    def check_player_guess
        if (@secret_word.include?(@letter_guess))
            @secret_word.each_index do |index|
                if (@secret_word[index] == @letter_guess)
                    @player_guesses[index] = @secret_word[index]
                end
            end
        else
            @mistakes_left -= 1
            unless (@incorrect_letters.include?(@letter_guess))
                @incorrect_letters << @letter_guess
            end
        end
    end

    def check_game_status
        if (@mistakes_left == 0)
            return 0
        elsif (!@player_guesses.include?("_"))
            return 1
        else  
            return 2
        end
    end

    def print_game_information
        puts "You have #{@mistakes_left} mistakes left!"
        puts "Incorrect Letters: #{@incorrect_letters}"
        @player_guesses.each { |value| print "#{value} " }
        puts ""
        if (@mistakes_left == 0)
            puts @secret_word.join
        end
    end
end

hangman = Game.new

while (hangman.check_game_status == 2)
    hangman.print_game_information
    hangman.get_player_guess
    hangman.check_player_guess
end

hangman.print_game_information

if hangman.check_game_status == 1
    puts "You won! Great guesses!"
elsif hangman.check_game_status == 0
    puts "You lost..."
end