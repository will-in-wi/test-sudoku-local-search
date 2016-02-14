require 'colorize'

require 'context_square'
require 'square'
require 'solver'

class Board
  attr_reader :squares

  def initialize(arr)
    raise ArgumentError, 'Invalid input array' unless valid_input_arr?(arr)

    @squares = arr.map { |row| row.map { |cell| Square.new cell } }
  end

  def square(row, col)
    @squares[row][col]
  end

  def context_square(row, col)
    ContextSquare.new(square(row, col), self, row, col)
  end

  def row(idx)
    @squares[idx]
  end

  def column(col)
    @squares.map { |row| row[col] }
  end

  # 0 1 2
  # 3 4 5
  # 6 7 8
  def quadrant(idx)
    start_row = (idx / 3) * 3
    case idx
    when 0
      [@squares[start_row][0],@squares[start_row][1],@squares[start_row][2],@squares[start_row + 1][0],@squares[start_row + 1][1],@squares[start_row + 1][2],@squares[start_row + 2][0],@squares[start_row + 2][1],@squares[start_row + 2][2]]
    when 1
      [@squares[start_row][3],@squares[start_row][4],@squares[start_row][5],@squares[start_row + 1][3],@squares[start_row + 1][4],@squares[start_row + 1][5],@squares[start_row + 2][3],@squares[start_row + 2][4],@squares[start_row + 2][5]]
    when 2
      [@squares[start_row][6],@squares[start_row][7],@squares[start_row][8],@squares[start_row + 1][6],@squares[start_row + 1][7],@squares[start_row + 1][8],@squares[start_row + 2][6],@squares[start_row + 2][7],@squares[start_row + 2][8]]
    when 3
      [@squares[start_row][0],@squares[start_row][1],@squares[start_row][2],@squares[start_row + 1][0],@squares[start_row + 1][1],@squares[start_row + 1][2],@squares[start_row + 2][0],@squares[start_row + 2][1],@squares[start_row + 2][2]]
    when 4
      [@squares[start_row][3],@squares[start_row][4],@squares[start_row][5],@squares[start_row + 1][3],@squares[start_row + 1][4],@squares[start_row + 1][5],@squares[start_row + 2][3],@squares[start_row + 2][4],@squares[start_row + 2][5]]
    when 5
      [@squares[start_row][6],@squares[start_row][7],@squares[start_row][8],@squares[start_row + 1][6],@squares[start_row + 1][7],@squares[start_row + 1][8],@squares[start_row + 2][6],@squares[start_row + 2][7],@squares[start_row + 2][8]]
    when 6
      [@squares[start_row][0],@squares[start_row][1],@squares[start_row][2],@squares[start_row + 1][0],@squares[start_row + 1][1],@squares[start_row + 1][2],@squares[start_row + 2][0],@squares[start_row + 2][1],@squares[start_row + 2][2]]
    when 7
      [@squares[start_row][3],@squares[start_row][4],@squares[start_row][5],@squares[start_row + 1][3],@squares[start_row + 1][4],@squares[start_row + 1][5],@squares[start_row + 2][3],@squares[start_row + 2][4],@squares[start_row + 2][5]]
    when 8
      [@squares[start_row][6],@squares[start_row][7],@squares[start_row][8],@squares[start_row + 1][6],@squares[start_row + 1][7],@squares[start_row + 1][8],@squares[start_row + 2][6],@squares[start_row + 2][7],@squares[start_row + 2][8]]
    end
  end

  def square_conflicts(rowidx, colidx)
    context_square(rowidx, colidx).conflicts
  end

  def square_valid?(rowidx, colidx)
    context_square(rowidx, colidx).valid?
  end

  def valid?
    9.times do |rowidx|
      9.times do |colidx|
        return false unless square_valid?(rowidx, colidx)
      end
    end

    true
  end

  def total_conflicts
    conflicts = 0
    each_context_square do |ctx_square|
      conflicts += ctx_square.conflicts
    end

    conflicts
  end

  def complete?
    valid? && @squares.map { |row| row.map(&:nil?) }.flatten.uniq == [false]
  end

  def solve!(max_runs)
    Solver.new(self).solve!(max_runs)
  end

  def each_square
    @squares.flatten.each do |square|
      yield(square)
    end
  end

  def each_context_square
    @squares.each_with_index do |row, rowidx|
      row.each_with_index do |square, colidx|
        yield(context_square(rowidx, colidx))
      end
    end
  end

  def print!
    @squares.each_with_index do |row, rowidx|
      r = row.map.with_index do |square, colidx|
        if square.original?
          square.value.to_s
        elsif context_square(rowidx, colidx).conflicts > 0
          square.value.to_s.red
        else
          square.value.to_s.green
        end
      end

      puts r.join(' ')
    end
  end

  private

  def valid_input_arr?(arr)
    arr.size == 9 && arr.map(&:size) == [9] * 9
  end
end
