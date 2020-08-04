COLORS = ["red", "blue", "green", "yellow", "purple", "orange"]

#create the player (name, guessing or choosing)
class Player
  attr_reader :name, :action
  attr_accessor :score
  $player_action = ""

  def initialize(name, action, score = [0, 0])
    @name = name
    @action = action
    @score = score
    $player_action = action
  end
end

#computer chooses code
def computer_choose
  color_rand = COLORS.shuffle
  code = []

  (0..3).each {|i| code << color_rand[i]}

  return code
end

#compare guess and code
def compare (code, guess)
  in_code = 0
  correct_spot = 0 

  (0..3).each do |i|
    if code[i] == guess[i]
      correct_spot += 1
    elsif code.include?(guess[i])
      in_code += 1
    end
  end

  return [in_code, correct_spot]
end

#clean up code (guess or create)
def clean_up (input)
  if input.include?(",")
    code_array = input.split(", ")
  else
    code_array = input.split(" ")
  end

  return code_array
end

#computer guesses
def comp_guess (player)
  options = COLORS.join(", ")
  puts "#{player.name}, create a code by choosing four of the following options: #{options}"
  code = gets.chomp.downcase
  code = clean_up(code)

  guesses = 0
  round_complete = false

  until round_complete do
    if guesses < 12
      comp_guess = computer_choose
      test_score = compare(code, comp_guess)
      puts "Computer guesses: #{comp_guess.join(", ")}"
      puts " "     
      if test_score[1] == 4
        result = "lose"
        round_complete = true
      else
        puts "#{test_score[1]} are in the correct spot. #{test_score[0]} are included in the code, but in the wrong order."
        guesses += 1
        puts "#{guesses} guesses. #{(12-guesses)} guesses left."
        puts " "
      end
    else
      result = "win"
      round_complete = true
    end
  end

  return result
end

#player guesses
def play_guess (code, player)
  guesses = 0
  round_complete = false
  options = COLORS.join(", ")

  until round_complete do
    if guesses < 12
      puts "Your options: #{options}"
      puts "#{player.name}, what do you believe the code is?"
      guess = gets.chomp.downcase
      puts " "
      guess = clean_up(guess)
      test_score = compare(code, guess)
      if test_score[1] == 4
        result = "win"
        round_complete = true
      else
        puts "#{test_score[1]} are in the correct spot. #{test_score[0]} are included in the code, but in the wrong order."
        guesses += 1
        puts "#{guesses} guesses. #{(12-guesses)} guesses left."
        puts " "
      end
    else
      result = "lose"
      round_complete = true
    end
  end

  return result
end

#create a player
def create_player
  valid_action = false
  puts "What is your name?"
  name = gets.chomp.capitalize

  until valid_action do
    puts " "
    puts "Do you want to guess the code or create the code? (Guess/Create)"
    action = gets.chomp.downcase

    if action == "guess" || action == "create"
      valid_action = true
    else
      puts "Invalid Option"
    end
    puts " "
  end
  
  player = Player.new(name, action)
  return player
end

#start game
def game_play
  puts "Welcome to Mastermind. In this game a code will be created with a combination of four colors. If you choose to guess, you will have 12 guesses to try to guess the combination of colors that the computer has created. If you choose to create the code, you will create the code for the computer to guess."
  puts " "
  puts "Let's start by creating your game."
  puts " "
  play_one = create_player

  if play_one.action == "guess"
    code = computer_choose
    result = play_guess(code, play_one)
  else
    result = comp_guess(play_one)
  end

  if result == "win"
    puts "Congrats, #{play_one.name}! You Win!"
    play_one.score[0] += 1
  else
    puts "Sorry, #{play_one.name}, you've lost. Try again."
    play_one.score[1] += 1
  end
end

game_play