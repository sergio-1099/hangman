require 'pry-byebug'

def choose_random_word
    dictionary = File.open("google-10000-english-no-swears.txt", "r")
    word = "A"
    
    while (word.length < 6 || word.length > 13)
        word_number = rand(9894) + 1
        word_number.times { word = dictionary.gets }
        word = "A" if word == nil
    end
    return word
end

class Game
    def initialize
        @secret_word = choose_random_word().upcase.split('')
        @secret_word.slice!(@secret_word.length - 1)
        @turns_left = 6
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
            @turns_left -= 1
            @incorrect_letters << @letter_guess
        end
    end

    def print_game_information
        puts "You have #{@turns_left} turns left!"
        puts "Incorrect Letters: #{@incorrect_letters}"
        @player_guesses.each { |value| print "#{value} " }
        puts ""
    end
end