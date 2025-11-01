# frozen_string_literal: true

require_relative 'codemaker'

# Game controller
class Game
  def initialize
    @codemaker = Codemaker.new
  end

  def guess_sequence(guess_sequence)
    # TODO: error-handling
    codemaker.compare guess_sequence
  end

  private

  attr_reader :codemaker
end
