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
        @secret_word = choose_random_word()
        @turns_left = 6
        @incorrect_letters = []
        @player_guesses = Array.new(@secret_word.length, "_")
    end

    def get_player_guess
        print "Enter a letter: "
        @letter = gets.chomp
    end

    def print_game_information
        puts "You have #{@turns_left} turns left!"
        puts "Incorrect Letters: #{@incorrect_letters}"
        @player_guesses.each { |value| print "#{value} " }
        puts ""
    end
end