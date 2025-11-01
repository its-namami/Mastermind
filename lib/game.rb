# frozen_string_literal: true

require_relative 'codemaker'

# Game controller
class Game
  def initialize
    @game_stop = false

    pp_game_info

    until game_stop
      @codemaker = Codemaker.new(CONFIGURATION[:row_size])

      @game_state = { round: 0, won: false }

      pp_colors
      play
      ask_retry
    end

    puts 'See you next time!'
  end

  def ask_retry
    print "Do you want play again? [y/N]\n>>> "
    input = gets.chomp

    self.game_stop =
      case input.downcase
      when 'y' then false
      when '', 'n' then true
      else
        puts 'Wrong input, try again'
        ask_retry
      end
  end

  def guess_sequence(guess_sequence)
    # TODO: error-handling
    codemaker.compare guess_sequence
  end

  private

  CONFIGURATION = {
    rounds: 8,
    row_size: 4
  }.freeze

  def pp_colors
    puts "Available colors: <#{Codemaker::COLORS.join(' ')}>"
  end

  def input_guess
    CONFIGURATION[:row_size].times.each_with_object([]) do |time, sequence|
      print "Input color ##{time + 1}\n>>> "
      input = gets.chomp

      if Codemaker::COLORS.include?(input)
        sequence << input
      else
        puts 'Wrong color!'
        pp_colors
        redo
      end

      puts
    end
  end

  def parse_answer(codemaker_answer)
    if codemaker_answer.eql?(Array.new(4, 'black'))
      game_state[:won] = true
    elsif !codemaker_answer.empty?
      puts "Codemaker says #{codemaker_answer.join(' ')}"
    else
      puts "Codemaker says you've got nuthin' right!"
    end
  end

  def pp_game_info
    puts <<~INFO

      Welcome to the Mastermind Game!

      Game Rules:
      - The Codemaker has selected a secret sequence of 4 colors.
      - You have up to #{CONFIGURATION[:rounds]} rounds to guess this sequence.
      - After each guess, the Codemaker will give you feedback:
        * "black" indicates a correct color in the correct position.
        * No feedback or other indicators means your guess has no correct colors or positions.
      - Use the feedback to improve your next guess.
      - The available colors are: #{Codemaker::COLORS.join(', ')}.

      How to Play:
      - In each round, you will be asked to input a sequence of 4 colors.
      - Enter each color one by one when prompted.
      - Make sure to only input from the available colors.
      - Try to guess the exact sequence before the rounds run out.

      Good luck and have fun!

    INFO
  end

  def play
    game_state[:round] += 1

    if game_state[:won]
      puts 'Congratulations, you guessed the correct sequence!'
    elsif game_state[:round] > CONFIGURATION[:rounds]
      puts 'Sorry, you lost!'
      puts "The correct sequence would be: #{codemaker.pop_sequence!.join(' ')}"
    else
      puts "Round #{game_state[:round]}"
      parse_answer(guess_sequence(input_guess))
      play
    end
  end

  attr_reader :codemaker

  attr_accessor :game_state, :game_stop
end
