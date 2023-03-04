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