require 'board'

# https://en.wikipedia.org/wiki/Sudoku
puzzle = [
  [5,  3,  nil,nil,7,  nil,nil,nil,nil],
  [6,  nil,nil,1,  9,  5,  nil,nil,nil],
  [nil,9,  8,  nil,nil,nil,nil,6,  nil],
  [8,  nil,nil,nil,6,  nil,nil,nil,3],
  [4,  nil,nil,8,  nil,3,  nil,nil,1],
  [7,  nil,nil,nil,2,  nil,nil,nil,6],
  [nil,6,  nil,nil,nil,nil,2,  8,  nil],
  [nil,nil,nil,4,  1,  9,  nil,nil,5],
  [nil,nil,nil,nil,8,  nil,nil,7  ,9]
]

board = Board.new puzzle

max_runs = ARGV[0].to_i || 500

board.solve! max_runs

if board.complete?
  puts 'Solved the board!'
else
  puts "Failed to solve. #{board.total_conflicts} remaining conflicts"
end

board.print!
