require 'board'

RSpec.describe Board do
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
  let(:finished_squares) do
    [
      [5,3,4,6,7,8,9,1,2],
      [6,7,2,1,9,5,3,4,8],
      [1,9,8,3,4,2,5,6,7],
      [8,5,9,7,6,1,4,2,3],
      [4,2,6,8,5,3,7,9,1],
      [7,1,3,9,2,4,8,5,6],
      [9,6,1,5,3,7,2,8,4],
      [2,8,7,4,1,9,6,3,5],
      [3,4,5,2,8,6,1,7,9]
    ]
  end
  let(:board) { Board.new squares }

  it 'accepts valid board size' do
    expect(board.square(0,0).value).to eq 5
  end

  context 'with invalid board size' do
    let(:squares) { [[1,2,3],[1,2,3],[1,2,3]] }

    it 'raises error' do
      expect { board }.to raise_error ArgumentError, 'Invalid input array'
    end
  end

  describe '#row' do
    it 'returns an array' do
      expect(board.row(3).map(&:value)).to eq [8,nil,nil,nil,6,nil,nil,nil,3]
      expect(board.row(3).map(&:class).uniq).to eq [Square]
    end
  end

  describe '#column' do
    it 'returns an array' do
      expect(board.column(2).map(&:value)).to eq [nil,nil,8,nil,nil,nil,nil,nil,nil]
      expect(board.column(2).map(&:class).uniq).to eq [Square]
    end
  end

  describe '#quadrant' do
    it 'returns an array' do
      expect(board.quadrant(2).map(&:value)).to eq [nil,nil,nil,nil,nil,nil,nil,6,nil]
      expect(board.quadrant(2).map(&:class).uniq).to eq [Square]
    end
  end

  describe 'valid?' do
    context 'with a valid board' do
      it 'returns true' do
        expect(board.valid?).to eq true
      end
    end

    context 'with a conflicting board' do
      let(:squares) do
        s = super()
        s[0][0] = 3
        s
      end

      it 'returns false' do
        expect(board.valid?).to eq false
      end
    end
  end

  describe '#square_conflicts' do
    context 'with valid board' do
      it 'returns 0' do
        expect(board.square_conflicts(0, 0)).to eq 0
      end
    end
  end

  describe '#complete?' do
    context 'when complete and valid' do
      let(:squares) { finished_squares }

      it 'returns true' do
        expect(board.complete?).to eq true
      end
    end

    context 'when incomplete and valid' do
      it 'returns false' do
        expect(board.complete?).to eq false
      end
    end

    context 'when invalid' do
      let(:squares) do
        finished_squares[0][0] = 3
        finished_squares
      end

      it 'returns false' do
        expect(board.complete?).to eq false
      end
    end
  end

  describe '#each_square' do
    it 'yields 9x9=81 times' do
      expect { |b| board.each_square(&b) }.to yield_control.exactly(81).times
    end
  end

  describe '#solve!' do
    pending 'solves the puzzle' do
      board.solve!
      9.times do |rowidx|
        9.times do |colidx|
          expect(board.square(rowidx, colidx).value).to eq(finished_squares[rowidx][colidx])
        end
      end
    end
  end
end
