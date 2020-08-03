COLORS = ["Red", "Blue", "Green", "Yellow", "Purple", "Orange"]

#create the player (name, guessing or choosing)
class Player
  attr_reader :name, :action
  attr_accessor :score
  $player_action = ""

  def initialize(name, action, score = 0)
    @name = name
    @action = action
    @score = score
    $player_action = action
  end
end

#computer chooses code
#computer guesses
#player makes guesses
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
end

game_play