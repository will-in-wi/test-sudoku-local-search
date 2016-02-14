require 'solver'
require 'board'

RSpec.describe Solver do
    let(:squares) do
    # https://en.wikipedia.org/wiki/Sudoku
    [
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
  end
  let(:board) { Board.new squares }
  let(:solver) { Solver.new board }

  describe '#fill_random!' do
    it 'fills empty squares with random numbers' do
      solver.fill_random!
      expect(board.squares.flatten).to all be_not_nil
    end
  end

  describe '#solve!' do
  end

  describe '#find_least_conflicts' do
    it 'returns only valid results' do
      allowed_values = [1,2,4]
      ctx_square = board.context_square(0, 2)
      res = solver.find_least_conflicts(ctx_square)
      expect(allowed_values).to include res
    end
  end
end
