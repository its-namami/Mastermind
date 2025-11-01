# frozen_string_literal: true

# this class creates an anonymous sequence and compares with guesses
class Codemaker
  def initialize
    @sequence = generate_sequence
  end

  # promise it's same size and no nils
  def compare(guess_sequence)
    # TODO: refactor
    original_sequence = sequence
    result = []

    guess_sequence.each.with_index do |guess, index|
      if original_sequence.include?(guess)
        result << case original_sequence.index(guess)
                  when index
                    'RIGHT ON MONEY, ONE AT EXACT SPOT!'
                  else
                    'IT EXISTS BUT ON AT THE SAME SPOT'
                  end

        original_sequence[original_sequence.index(guess)] = nil
      end
    end

    result
  end

  private

  COLORS = %w[red orange yellow green blue purple].freeze

  def generate_sequence(size = 4)
    size.times.map { COLORS.sample }
  end

  attr_reader :sequence
end
