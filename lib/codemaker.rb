# frozen_string_literal: true

# this class creates an anonymous sequence and compares with guesses
class Codemaker
  COLORS = %w[red orange yellow green blue purple].freeze

  def initialize(size)
    @sequence = generate_sequence(size)
  end

  def pop_sequence!
    sequence = self.sequence
    self.sequence = nil
    sequence
  end

  def compare(guess_sequence)
    # TODO: refactor
    original_sequence = sequence.clone
    result = []

    original_sequence.each.with_index do |color, index|
      if guess_sequence.include?(color)
        result <<
          case guess_sequence[index]
          when color
            guess_sequence[index] = nil
            'black'
          else
            guess_sequence[guess_sequence.index(color)] = nil
            'white'
          end

        original_sequence[index] = nil
      end
    end

    result
  end

  private

  def generate_sequence(size = 4)
    size.times.map { COLORS.sample }
  end

  attr_accessor :sequence
end
