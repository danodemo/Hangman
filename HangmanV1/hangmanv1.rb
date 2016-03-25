require "pry"
require "set"

word_list = [
  "chicken", "gnome", "courage", "uhmerica", "idiomatic", "dogmatic",
"foxtrot", "alienation", "antidisestablishmentarianism", "dog", "beer",
 "porkchop", "bacon", "pizza", "ruby", "zip", "zap", "pow"
]

MAX_TURNS = 7
answer = word_list.sample

def greeting(p1, p2)
  pry
  puts
  puts
  puts "Welcome, adventurers!"
  sleep(1)
  puts "The King of the Internet has arrested an innocent man."
  sleep(2)
  puts "By His royal decree, a game is to be played to determine the man's fate."
  sleep(2)
  puts "His most honored Majesty is thinking of a word, and he seeks someone"
  puts "to guess the word he is thinking of within 7 tries!"
  sleep(3)
  puts "YOU BOTH have been chosen by His royal Highness to play the game."
  sleep(2)
  puts " 'The rules are thus,' the Royal Guard Captain bellows out,"
  sleep(2)
  puts " '#{p1} shall guess a single, lowercase letter from the English alphabet."
  sleep(1)
  puts " Once said letter has been guessed, and only then, shall you know if thine guess"
  puts " be true.  If it is, let it be recorded henceforth! "
  sleep(1)
  puts " Thus, #{p1}'s turn being completed, #{p2}'s turn should commence with due haste,"
  puts " using the same criteria previously set forth by His Royal decree. ' "
  sleep (2)
  puts "The King stares at you both with wild eyes, and, with a twisted laugh, yells out:"
  sleep(2)
  puts "Are you ready to have someone's life in your hands?"
  sleep(1)
  puts "Are you ready to be..."
  sleep(3)
  puts "THE HANGMAN?!"
  puts
  puts
  sleep(3)
end

def game_over?(answer, guesses)
  turns_left(guesses, answer).zero? || win?(answer, guesses)
end

def show_progress(partial_word, answer, guesses, current_player)
  turns_remaining = turns_left(guesses, answer)
  puts
  puts "Thusly, #{current_player} have surmised of the King's riddle the following:\n#{partial_word}"
  puts "#{current_player} has #{turns_remaining} guesses left before an innocent man is murdered."
  puts "His children watch in horror, knowing their father's life is in your hands."
  sleep(1)
  puts "No pressure."
end

def prompt_player(current_player) 
  puts
  puts "#{current_player}, the King demands you choose a letter!"
  letter = gets.chomp
  until ('a'..'z').to_a.include?(letter)
    puts "Fool!  You were warned to only pick a single, LOWERCASE letter!"
    puts "Tempt the Royal Guards again and you will be skewered like a roasted goat!"
    puts "Now make a guess worthy of the King's game, or suffer a fate worse than death!"
    puts
    letter = gets.chomp
  end
  letter
end

def make_partial(guesses, answer)
  # blank a letter in the answer if it isn't in the guesses
  answer.chars.map do |letter|
    if guesses.include?(letter)
      letter
    else
      "-"
    end
  end
end

def take_turn(guesses, answer, current_player)
  partial_word = make_partial(guesses, answer).join
  show_progress(partial_word, answer, guesses, current_player)
  prompt_player(current_player)
end

def win?(answer, guesses)
  answer_set = answer.chars.to_set
  # guesses.superset?(answer_set)
  guesses >= answer_set
end

def postmortem(answer, guesses)
  if win?(answer, guesses)
    puts
    puts
    puts "                 You've done it!"
    puts "The crowd erupts in boos as you correctly guess #{answer}!"
    sleep(1)
    puts "The King is furious that you stole the joy of murder from him."
    sleep(1)
    puts "He frees the innocent man..."
    sleep(3)
    puts "And orders his guards to arrest YOU!  They lunge for you, binding your hands in rope."
    sleep(1)
    puts "Although you struggle valiantly, the King's guards manage to fit you into the noose..."
    sleep(1)
    puts "As the crowds chant merciless approval, the King gleefully throws the lever."
    sleep(1)
    puts "As your body starts to grow cold, you realize that nobody really wins in this game."
    puts
    puts
  else
    puts
    puts
    puts "         The guards snicker at your incompetence."
    puts "The King belts out a derisive laugh: you have failed to guess the word."
    sleep(1)
    puts " 'The word was #{answer}!' The King squeals in delight as he throws the lever."
    sleep (1)
    puts "You watch in horror as the man, kicking and choking, starts to turn blue."
    sleep(1)
    puts "His body turns still save for the occasional twitch, and sways gently in the breeze.  The man is dead."
    sleep(1)
    puts "You turn your head in shame, the sound of the King's cackling laughter haunting you."
    puts "The horror of the King's game will haunt you for the rest of your days."
    puts
    puts
  end
end

def turns_left(guesses, answer)
  answer_set = answer.chars.to_set
  wrong_guesses = (guesses - answer_set).count
  # wrong_guesses = guesses.difference(answer_set).count
  MAX_TURNS - wrong_guesses
end

def get_player_name(player)
  puts player + (" please enter your name:")
  gets.chomp
end

def hangman(answer)
  player1 = get_player_name("Player 1")
  player2 = get_player_name("Player 2")
  guess1 = Set.new
  guess2 = Set.new
  greeting(player1, player2)
  guesses = guess1
  current_player = player1
  until game_over?(answer, guesses)
    guess = take_turn(guesses, answer, current_player)
    guesses.add(guess)
    if !answer.include?(guess)
    if current_player == player1
      current_player = player2
      guesses = guess2
    else
      current_player = player1
      guesses = guess1
    end
  end
end
  postmortem(answer, guesses)
end

def play_again?
  puts "Would you like to play again? (y/n)"
  gets.chomp
end

def play_hangman(words)
  answer = words.sample
  hangman(answer)
end

def play(words)
  play_hangman(words)
  choice = play_again?
  until choice == "n"
    play_hangman(words)
    choice = play_again?
  end
end

play(word_list)