require 'pry'
require 'square'

class Solver
  def initialize(board)
    @board = board
  end

  def fill_random!
    valid_vals = Square::VALID_VALS.to_a
    @board.each_square do |square|
      next if square.original?
      square.value = valid_vals.shuffle.first
    end
  end

  def solve!(max_iterations = 500)
    fill_random!

    i = 0
    until @board.complete? || i >= max_iterations
      @board.each_context_square do |ctx_square|
        next if ctx_square.square.original?
        ctx_square.square.value = find_least_conflicts(ctx_square)
        break if @board.complete?
      end

      puts '---'
      @board.print!

      i += 1
    end
  end

  def find_least_conflicts(ctx_square)
    test_square = ctx_square.dup

    conflicts = {}
    Square::VALID_VALS.each do |i|
      test_square.square.value = i
      conflicts[test_square.conflicts] ||= []
      conflicts[test_square.conflicts] << i
    end

    possible_values = conflicts[conflicts.keys.sort.first]

    # binding.pry
    # p @board.total_conflicts

    # Pick a random value from the least conflicting set.
    possible_values.shuffle.first
  end
end
