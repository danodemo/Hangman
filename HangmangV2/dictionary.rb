class Dictionary

def initialize
  @word_list = [ "cookies", "dogs", "politics", "google",
        "funky", "satellite", "triscuit", "biscuit", "wheat",
        "regular", "expressions", "chicken", "axis", "cats",
        "handy", "wrench", "marijuana", "fajita", "wings",
        "burrito", "lunch", "gyroscope", "elephant", "word",
        "grammar", "antidisestablishmentarianism", "reciprocal",
        "elusive", "evolution"
  ]
  
end

def random_word
  word = @word_list.sample
end

end

