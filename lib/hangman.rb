def choose_random_word
    dictionary = File.open("google-10000-english-no-swears.txt", "r")
    word_number = rand(9894) + 1
    word = ''

    word_number.times { word = dictionary.gets }
    return word
end