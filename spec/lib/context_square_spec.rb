require 'square'
require 'context_square'
require 'board'

RSpec.describe ContextSquare do
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
  let(:row) { 0 }
  let(:col) { 1 }
  let(:square) { board.square(row, col) }
  let(:ctx_square) { ContextSquare.new(square, board, row, col) }

  it 'returns the right values' do
    expect(ctx_square.square).to eq square
    expect(ctx_square.square.value).to eq 3
  end

  describe '#conflicts' do
    it 'returns 0 for valid board' do
      expect(ctx_square.conflicts).to eq 0
    end

    it 'returns 1 for board with 1 conflict' do
      board.square(0, 3).value = 3
      expect(ctx_square.conflicts).to eq 1
    end
  end

  describe '#row_conflicts' do
    it 'returns 0 for valid row' do
      expect(ctx_square.row_conflicts).to eq 0
    end

    it 'returns 1 for board with 1 conflict' do
      board.square(0, 2).value = 3
      expect(ctx_square.row_conflicts).to eq 1
    end
  end

  describe '#col_conflicts' do
    it 'returns 0 for valid board' do
      expect(ctx_square.col_conflicts).to eq 0
    end

    it 'returns 1 for board with 1 conflict' do
      board.square(1, 1).value = 3
      expect(ctx_square.col_conflicts).to eq 1
    end
  end

  describe '#quad_conflicts' do
    it 'returns 0 for valid board' do
      expect(ctx_square.quad_conflicts).to eq 0
    end

    it 'returns 1 for board with 1 conflict' do
      board.square(2, 0).value = 3
      expect(ctx_square.quad_conflicts).to eq 1
    end
  end

  # 0 1 2
  # 3 4 5
  # 6 7 8
  describe '#quadrant' do
    it 'returns quadrant 0' do
      expect(ctx_square.quadrant).to eq 0
    end
  end

  describe '#valid?' do
    it 'returns true for valid board' do
      expect(ctx_square.valid?).to eq true
    end

    it 'returns 1 for board with 1 conflict' do
      board.square(1, 1).value = 3
      expect(ctx_square.valid?).to eq false
    end
  end

  describe '#dup' do
    let(:row) { 1 }

    it 'does not modify the original value' do
      dup_ctx_square = ctx_square.dup
      expect(ctx_square.square.value).to be_nil
      expect(dup_ctx_square.square.value).to be_nil
      dup_ctx_square.square.value = 5
      expect(ctx_square.square.value).to be_nil
      expect(dup_ctx_square.square.value).to eq 5
    end
  end
end
